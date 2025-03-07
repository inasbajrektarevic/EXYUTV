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
    public class ChannelCategoriesService : BaseService<ChannelCategory, int, ChannelCategoryModel, ChannelCategoryUpsertModel, BaseSearchObject>, IChannelCategoriesService
    {
        public ChannelCategoriesService(IMapper mapper, IValidator<ChannelCategoryUpsertModel> validator, DatabaseContext databaseContext) : base(mapper, validator, databaseContext)
        {

        }

        public override async Task<PagedList<ChannelCategoryModel>> GetPagedAsync(BaseSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var pagedList = await DbSet
                .Where(x => searchObject.SearchFilter == null ||
                x.Name.ToLower().Contains(searchObject.SearchFilter.ToLower()))
                .Select(x => new ChannelCategory
                {
                    Id = x.Id,
                    IsActive = x.IsActive,
                    DateCreated = x.DateCreated,
                    Description = x.Description,
                    Name = x.Name,
                    OrderNumber = x.OrderNumber,
                    Channels = x.Channels.Select(ch => new Channel
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
                })
                .ToPagedListAsync(searchObject);

            return Mapper.Map<PagedList<ChannelCategoryModel>>(pagedList);
        }
        public async Task<IEnumerable<KeyValuePair<int, string>>> GetDropdownItems()
        {
            return await DbSet.Select(c => new KeyValuePair<int, string>(c.Id, c.Name)).ToListAsync();
        }

        public Task<int> Count(CancellationToken cancellationToken = default)
        {
            return DbSet.Where(x => x.IsDeleted == false && x.IsActive).CountAsync(cancellationToken);
        }
    }
}
