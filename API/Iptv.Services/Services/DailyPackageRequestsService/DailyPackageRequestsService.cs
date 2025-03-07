using AutoMapper;
using FluentValidation;
using Iptv.Core;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services.Database;
using Iptv.Services.Extensions;
using Iptv.Shared;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace Iptv.Services
{
    public class DailyPackageRequestsService : BaseService<DailyPackageRequest, int, DailyPackageRequestModel, DailyPackageRequestUpsertModel, DailyPackageRequestsSearchObject>, IDailyPackageRequestsService
    {
        private readonly IEmail _email;
        public DailyPackageRequestsService(IMapper mapper, IEmail email, IValidator<DailyPackageRequestUpsertModel> validator, DatabaseContext databaseContext) : base(mapper, validator, databaseContext)
        {
            _email = email;
        }

        public override async Task<PagedList<DailyPackageRequestModel>> GetPagedAsync(DailyPackageRequestsSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var pagedList = await DbSet.Include(x => x.Application).Include(x => x.Device)
                .Where(x => (searchObject.SearchFilter == null ||
                x.FirstName.ToLower().Contains(searchObject.SearchFilter.ToLower()) ||
                x.LastName.ToLower().Contains(searchObject.SearchFilter.ToLower())) &&
                (searchObject.DeviceId == null || x.DeviceId == searchObject.DeviceId) &&
                (searchObject.ApplicationId == null || x.ApplicationId == searchObject.ApplicationId))
                .ToPagedListAsync(searchObject);
            return Mapper.Map<PagedList<DailyPackageRequestModel>>(pagedList);
        }
        public override async Task<DailyPackageRequestModel> AddAsync(DailyPackageRequestUpsertModel model, CancellationToken cancellationToken = default)
        {
            await ValidateAsync(model, cancellationToken);

            model.Status = UserPackageRequestStatus.InProcess;
            model.DateTimeFrom = model.DateTimeTo = DateTime.Now;

            var entity = Mapper.Map<DailyPackageRequest>(model);
            entity.Id = default;

            await DbSet.AddAsync(entity, cancellationToken);
            await DatabaseContext.SaveChangesAsync(cancellationToken);
            return Mapper.Map<DailyPackageRequestModel>(entity);
        }

        public async Task<DailyPackageRequestModel> UpdateStatus(int id, UserPackageRequestStatus status, CancellationToken cancellationToken = default)
        {
            var request = await DbSet.FirstOrDefaultAsync(o => o.Id == id);

            if (request == null)
            {
                throw new Exception("Order not found");
            }

            request.Status = status;
            if(request.Status == UserPackageRequestStatus.Finished)
            {
                request.DateTimeFrom = DateTime.Now;
                request.DateTimeTo = request.DateTimeFrom.AddDays(1);
            }
            DbSet.Update(request);
            await DatabaseContext.SaveChangesAsync(cancellationToken);

            if (status == UserPackageRequestStatus.Finished)
            {
                var message = EmailMessages.GenerateDailyRequestEmail($"{request.FirstName} {request.LastName}", $"{request.DateTimeFrom.ToString("dd.MM.yyyy HH:mm")} - {request.DateTimeTo.ToString("dd.MM.yyyy HH:mm")}", Guid.NewGuid().ToString());
                await _email.Send(EmailMessages.DailyRequestSubject, message, request.Email);
            }
            return Mapper.Map<DailyPackageRequestModel>(request);
        }
    }
}
