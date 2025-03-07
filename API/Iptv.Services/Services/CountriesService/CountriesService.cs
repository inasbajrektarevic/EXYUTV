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
    public class CountriesService : BaseService<Country, int, CountryModel, CountryUpsertModel, BaseSearchObject>, ICountriesService
    {
        public CountriesService(IMapper mapper, IValidator<CountryUpsertModel> validator, DatabaseContext databaseContext) : base(mapper, validator, databaseContext)
        {

        }

        public override async Task<PagedList<CountryModel>> GetPagedAsync(BaseSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var pagedList = await DbSet
                .Where(x => searchObject.SearchFilter == null ||
                x.Name.ToLower().Contains(searchObject.SearchFilter.ToLower()))
                .ToPagedListAsync(searchObject);
            return Mapper.Map<PagedList<CountryModel>>(pagedList);
        }

        public async Task<IEnumerable<KeyValuePair<int, string>>> GetDropdownItems()
        {
            return await DbSet.Select(c => new KeyValuePair<int, string>(c.Id, c.Name)).ToListAsync();
        }
    }
}
