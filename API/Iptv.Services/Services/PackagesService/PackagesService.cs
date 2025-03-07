using AutoMapper;
using FluentValidation;
using Iptv.Core;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services.Database;
using Iptv.Services.Extensions;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;

namespace Iptv.Services
{
    public class PackagesService : BaseService<Package, int, PackageModel, PackageUpsertModel, PackagesSearchObject>, IPackagesService
    {
        public PackagesService(IMapper mapper, IValidator<PackageUpsertModel> validator, DatabaseContext databaseContext) : base(mapper, validator, databaseContext)
        {

        }

        public override async Task<PackageModel?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            var entity = await DbSet
                .AsNoTracking()
                .Include(c => c.Country)
                .Include(c => c.ChannelCategories)
                .FirstOrDefaultAsync(c => c.Id == id);
            return Mapper.Map<PackageModel>(entity);
        }

        public async Task<List<EntityItemModel>> GetActivePackages()
        {
            var entities = await DbSet.Where(x => x.IsDeleted == false && x.Status == PackageStatus.Active).Select(x => new EntityItemModel
            {
                Id = x.Id,
                Label = x.Name
            }).ToListAsync();

            return entities;
        }

        public override async Task<PagedList<PackageModel>> GetPagedAsync(
            PackagesSearchObject searchObject,
            CancellationToken cancellationToken = default)
        {
            var query = DbSet
                .Where(x => searchObject.SearchFilter == null ||
                x.Name.ToLower().Contains(searchObject.SearchFilter.ToLower()))
                .Select(p => new PackageModel
                {
                    Id = p.Id,
                    Name = p.Name,
                    CountryId = p.CountryId,
                    CreatedById = p.CreatedById,
                    DateCreated = p.DateCreated,
                    Description = p.Description,
                    Discount = p.Discount,
                    IconUrl = p.IconUrl,
                    IsPromotional = p.IsPromotional,
                    Price = p.Price,
                    RequiresSubscription = p.RequiresSubscription,
                    Status = p.Status,
                    Country = new CountryModel
                    {
                        Id = p.Country.Id,
                        Name = p.Country.Name,
                        Abrv = p.Country.Abrv,
                        IsActive = p.Country.IsActive
                    },
                    ChannelCategories = p.ChannelCategories.Select(cc => new PackageChannelCategory
                    {
                        Id = cc.ChannelCategoryId,
                        PackageId = cc.PackageId,
                        ChannelCategoryId = cc.ChannelCategoryId,
                        ChannelCategory = new ChannelCategory
                        {
                            Id = cc.ChannelCategoryId,
                            IsActive = cc.ChannelCategory.IsActive,
                            Description = cc.ChannelCategory.Description,
                            Name = cc.ChannelCategory.Name,
                            OrderNumber = cc.ChannelCategory.OrderNumber,
                            Channels = cc.ChannelCategory.Channels.Select(ch => new Channel
                            {
                                Id = ch.Id,
                                Name = ch.Name,
                                ChannelLanguageId = ch.ChannelLanguageId,
                                ChannelLanguage = ch.ChannelLanguage,
                                ChannelNumber = ch.ChannelNumber,
                                CountryId = ch.CountryId,
                                Description = ch.Description,
                                Frequency = ch.Frequency,
                                IsHD = ch.IsHD,
                                LogoUrl = ch.LogoUrl,
                                Owner = ch.Owner,
                                StreamUrl = ch.StreamUrl,
                                Country = ch.Country
                            }).ToList()
                        }
                    }).ToList()
                });

            var pagedList = await query.ToPagedListAsync(searchObject);
            return pagedList;
        }

        public override async Task<PackageModel> AddAsync(PackageUpsertModel model, CancellationToken cancellationToken = default)
        {
            await ValidateAsync(model, cancellationToken);

            var channelCategories = JsonConvert.DeserializeObject<List<int>>(model.ChannelCategorieIds);

            var entity = Mapper.Map<Package>(model);

            entity.Id = default;
            entity.ChannelCategories = null!;
            await DbSet.AddAsync(entity, cancellationToken);
            await DatabaseContext.SaveChangesAsync(cancellationToken);

            var packageChannelCategories = new List<PackageChannelCategory>();

            foreach (var item in channelCategories!)
            {
                packageChannelCategories.Add(new PackageChannelCategory
                {
                    ChannelCategoryId = item,
                    PackageId = entity.Id
                });
            }

            await DatabaseContext.PackageChannelCategories.AddRangeAsync(packageChannelCategories);
            await DatabaseContext.SaveChangesAsync(cancellationToken);

            return Mapper.Map<PackageModel>(entity);
        }

        public override async Task<PackageModel> UpdateAsync(PackageUpsertModel model, CancellationToken cancellationToken = default)
        {
            await ValidateAsync(model, cancellationToken);

            var channelCategories = JsonConvert.DeserializeObject<List<int>>(model.ChannelCategorieIds);
            var package = await GetByIdAsync(model.Id!.Value, cancellationToken);

            if (package == null)
            {
                throw new Exception("Package not found");
            }

            var packageChannelCategoriesForInsert = new List<PackageChannelCategory>();

            var packageChannelCategoriyIdsForDelete = package.ChannelCategories
            .Where(currentChannelCategory => !currentChannelCategory.IsDeleted && !channelCategories!.Any(channelCategoryId => channelCategoryId == currentChannelCategory.ChannelCategoryId))
            .Select(x => x.Id);
            var packageChannelCategoriesForDelete = DatabaseContext.PackageChannelCategories.Where(x => packageChannelCategoriyIdsForDelete.Any(id => id == x.Id));

            var existingCategoryIds = package.ChannelCategories.Select(x => x.ChannelCategoryId).ToList();
            var categoriesToInsert = channelCategories!.Except(existingCategoryIds).ToList();

            packageChannelCategoriesForInsert.AddRange(categoriesToInsert.Select(categoryId => new PackageChannelCategory
            {
                PackageId = package.Id,
                ChannelCategoryId = categoryId
            }));

            await DatabaseContext.PackageChannelCategories.AddRangeAsync(packageChannelCategoriesForInsert);
            DatabaseContext.PackageChannelCategories.RemoveRange(packageChannelCategoriesForDelete);

            model.ChannelCategorieIds = null!;
            var entity = Mapper.Map<Package>(model);

            entity.ChannelCategories = null!;
            DbSet.Update(entity);
            await DatabaseContext.SaveChangesAsync(cancellationToken);

            return Mapper.Map<PackageModel>(entity);
        }

        public Task<int> Count(CancellationToken cancellationToken = default)
        {
            return DbSet.Where(x => x.IsDeleted == false).CountAsync(cancellationToken);
        }
    }
}
