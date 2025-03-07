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
    public class ChannelLanguagesService : BaseService<ChannelLanguage, int, ChannelLanguageModel, ChannelLanguageUpsertModel, BaseSearchObject>, IChannelLanguagesService
    {
        public ChannelLanguagesService(IMapper mapper, IValidator<ChannelLanguageUpsertModel> validator, DatabaseContext databaseContext) : base(mapper, validator, databaseContext)
        {

        }

        public override async Task<PagedList<ChannelLanguageModel>> GetPagedAsync(BaseSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var pagedList = await DbSet
                .Where(x => searchObject.SearchFilter == null ||
                x.Name.ToLower().Contains(searchObject.SearchFilter.ToLower()))
                .ToPagedListAsync(searchObject);
            return Mapper.Map<PagedList<ChannelLanguageModel>>(pagedList);
        }
        public async Task<IEnumerable<KeyValuePair<int, string>>> GetDropdownItems()
        {
            return await DbSet.Select(c => new KeyValuePair<int, string>(c.Id, c.Name)).ToListAsync();
        }
    }
}
