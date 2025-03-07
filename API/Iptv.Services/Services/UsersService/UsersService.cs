using AutoMapper;
using FluentValidation;
using Iptv.Core;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services.Database;
using Iptv.Services.Extensions;
using Iptv.Shared;
using Iptv.Shared.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace Iptv.Services
{
    public class UsersService : BaseService<User, int, UserModel, UserUpsertModel, UsersSearchObject>, IUsersService
    {
        private readonly IPasswordHasher<User> _passwordHasher;
        private readonly ICrypto _crypto;
        private readonly IEmail _email;
        private readonly IConfiguration _configuration;
        private readonly IRabbitMQProducer _rabbitMQProducer;
        public UsersService(IMapper mapper, IValidator<UserUpsertModel> validator, DatabaseContext databaseContext,
            IPasswordHasher<User> passwordHasher, ICrypto crypto, IEmail email, IRabbitMQProducer rabbitMQProducer, IConfiguration configuration) : base(mapper, validator, databaseContext)
        {
            _passwordHasher = passwordHasher;
            _crypto = crypto;
            _email = email;
            _configuration = configuration;
            _rabbitMQProducer = rabbitMQProducer;
        }

        public override async Task<PagedList<UserModel>> GetPagedAsync(UsersSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var pagedList = await DbSet
                .Where(x => (searchObject.SearchFilter == null ||
                x.FirstName.ToLower().Contains(searchObject.SearchFilter.ToLower()) ||
                x.LastName.ToLower().Contains(searchObject.SearchFilter.ToLower()) ||
                x.Email!.ToLower().Contains(searchObject.SearchFilter.ToLower())) &&
                x.UserRoles.Any(x => x.RoleId == (int)RoleLevel.Client))
                .ToPagedListAsync(searchObject);
            return Mapper.Map<PagedList<UserModel>>(pagedList);
        }

        public async Task<UserLoginDataModel?> FindByUserNameOrEmailAsync(string userName, CancellationToken cancellationToken = default)
        {
            var user = await DbSet
                .AsNoTracking()
                .Include(u => u.UserRoles)
                .ThenInclude(u => u.Role)
                .FirstOrDefaultAsync(u => u.UserName == userName || u.Email == userName);
            return Mapper.Map<UserLoginDataModel>(user);
        }

        public async Task<List<UserModel>> GetClientByBirthDateRange(int yearFrom, int yearTo)
        {
            var entities = await DbSet.Where(x => x.BirthDate != null && x.BirthDate.Value.Year >= yearFrom && x.BirthDate.Value.Year <= yearTo).ToListAsync();
            return Mapper.Map<List<UserModel>>(entities);
        }
        public override async Task<UserModel> AddAsync(UserUpsertModel model, CancellationToken cancellationToken = default)
        {
            await CheckUserExist(model.Email);

            User? entity = null;
            try
            {
                await ValidateAsync(model, cancellationToken);

                var roles = await DatabaseContext.Roles.ToListAsync();

                entity = Mapper.Map<User>(model);

                if (entity.UserRoles == null)
                {
                    entity.UserRoles = new List<UserRole>();
                }

                if (model.IsClient)
                {
                    entity.UserRoles.Add(new UserRole
                    {
                        RoleId = roles.Single(x => x.RoleLevel == RoleLevel.Client).Id
                    });
                }

                entity.IsActive = true;
                entity.IsFirstLogin = true;
                entity.VerificationSent = true;
                entity.NormalizedEmail = entity.Email?.ToUpper();
                entity.UserName = entity.Email;
                entity.NormalizedUserName = entity.NormalizedEmail;
                entity.EmailConfirmed = true;
                entity.PhoneNumberConfirmed = true;
                entity.SecurityStamp = Guid.NewGuid().ToString();

                var token = _crypto.GenerateSalt();
                token = _crypto.CleanSalt(token);

                var password = _crypto.GeneratePassword();
                entity.PasswordHash = _passwordHasher.HashPassword(new User(), password);

                await DbSet.AddAsync(entity, cancellationToken);
                await DatabaseContext.SaveChangesAsync(cancellationToken);

                var message = EmailMessages.GeneratePasswordEmail($"{entity.FirstName} {entity.LastName}", password, token, _configuration["ClientUrl"]!);
                //await _email.Send(EmailMessages.ConfirmationEmailSubject, message, entity.Email!);

                var email = new EmailModel
                {
                    Title = EmailMessages.ConfirmationEmailSubject,
                    Body = message,
                    Email = entity.Email!,
                };
                _rabbitMQProducer.SendMessage(email);

                return Mapper.Map<UserModel>(entity);
            }
            catch
            {

                throw;
            }
        }

        private async Task CheckUserExist(string email, User? user = null)
        {
            if ((user == null || user?.Email != email) && (await DbSet.FirstOrDefaultAsync(u => u.Email == email)) != null)
            {
                throw new Exception("UserEmailExist");
            }
        }

        public Task<int> ClientCount(CancellationToken cancellationToken = default)
        {
            return DbSet.Where(x => x.UserRoles.Any(x => x.RoleId == (int)RoleLevel.Client)
            && x.IsDeleted == false).CountAsync(cancellationToken);
        }

        public async Task<Dictionary<DateTime, int>> GetDailyClientRegistrationsAsync(CancellationToken cancellationToken = default)
        {
            var sevenDaysAgo = DateTime.UtcNow.Date.AddDays(-6);

            var result = await DbSet
                .Where(x => x.UserRoles.Any(r => r.RoleId == (int)RoleLevel.Client)
                            && x.DateCreated >= sevenDaysAgo
                            && x.IsDeleted == false)
                .GroupBy(x => x.DateCreated.Date)
                .Select(g => new { Date = g.Key, Count = g.Count() })
                .ToListAsync(cancellationToken);

            var dailyCounts = Enumerable.Range(0, 7)
                .Select(i => sevenDaysAgo.AddDays(i))
                .ToDictionary(date => date, date => result.FirstOrDefault(r => r.Date == date)?.Count ?? 0);

            return dailyCounts;
        }

    }
}
