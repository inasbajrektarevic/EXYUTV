using AutoMapper;
using FluentValidation;
using Iptv.Core;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services.Database;
using Iptv.Services.Extensions;
using Microsoft.EntityFrameworkCore;

namespace Iptv.Services
{
    public class ChannelsService : BaseService<Channel, int, ChannelModel, ChannelUpsertModel, ChannelsSearchObject>, IChannelsService
    {
        public ChannelsService(IMapper mapper, IValidator<ChannelUpsertModel> validator, DatabaseContext databaseContext) : base(mapper, validator, databaseContext)
        {

        }

        public override async Task<ChannelModel?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            var entity = await DbSet
            .Select(x => new Channel
            {
                Id = x.Id,
                ChannelCategoryId = x.ChannelCategoryId,
                DateCreated = x.DateCreated,
                Description = x.Description,
                Name = x.Name,
                ChannelLanguageId = x.ChannelLanguageId,
                ChannelNumber = x.ChannelNumber,
                CountryId = x.CountryId,
                Country = x.Country,
                Frequency = x.Frequency,
                IsHD = x.IsHD,
                LogoUrl = x.LogoUrl,
                Owner = x.Owner,
                StreamUrl = x.StreamUrl,
                ChannelCategory = new ChannelCategory
                {
                    Id = x.ChannelCategoryId,
                    Name = x.ChannelCategory.Name,
                    IsActive = x.ChannelCategory.IsActive,
                    Description = x.ChannelCategory.Description,
                    OrderNumber = x.ChannelCategory.OrderNumber,
                },
                ChannelLanguage = new ChannelLanguage
                {
                    IsActive = x.ChannelLanguage.IsActive,
                    CultureName = x.ChannelLanguage.CultureName,
                    Id = x.ChannelLanguageId,
                    Name = x.ChannelLanguage.Name,
                }
            }).FirstOrDefaultAsync(c => c.Id == id);

            return Mapper.Map<ChannelModel>(entity);
        }

        public override async Task<PagedList<ChannelModel>> GetPagedAsync(ChannelsSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var pagedList = await DbSet
            .Where(x => searchObject.SearchFilter == null ||
            x.Name.ToLower().Contains(searchObject.SearchFilter.ToLower()))
            .Select(x => new Channel
            {
                Id = x.Id,
                ChannelCategoryId = x.ChannelCategoryId,
                DateCreated = x.DateCreated,
                Description = x.Description,
                Name = x.Name,
                ChannelLanguageId = x.ChannelLanguageId,
                ChannelNumber = x.ChannelNumber,
                CountryId = x.CountryId,
                Country = x.Country,
                Frequency = x.Frequency,
                IsHD = x.IsHD,
                LogoUrl = x.LogoUrl,
                Owner = x.Owner,
                StreamUrl = x.StreamUrl,
                ChannelCategory = new ChannelCategory
                {
                    Id = x.ChannelCategoryId,
                    Name = x.ChannelCategory.Name,
                    IsActive = x.ChannelCategory.IsActive,
                    Description = x.ChannelCategory.Description,
                    OrderNumber = x.ChannelCategory.OrderNumber,
                },
                ChannelLanguage = new ChannelLanguage
                {
                    IsActive = x.ChannelLanguage.IsActive,
                    CultureName = x.ChannelLanguage.CultureName,
                    Id = x.ChannelLanguageId,
                    Name = x.ChannelLanguage.Name,
                }
            })
            .ToPagedListAsync(searchObject);

            return Mapper.Map<PagedList<ChannelModel>>(pagedList);
        }

        public Task<int> Count(CancellationToken cancellationToken = default)
        {
            return DbSet.Where(x => x.IsDeleted == false).CountAsync(cancellationToken);
        }
    }
}
