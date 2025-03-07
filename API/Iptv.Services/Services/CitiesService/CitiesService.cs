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
    public class CitiesService : BaseService<City, int, CityModel, CityUpsertModel, CitiesSearchObject>, ICitiesService
    {
        public CitiesService(IMapper mapper, IValidator<CityUpsertModel> validator, DatabaseContext databaseContext) : base(mapper, validator, databaseContext)
        {

        }

        public override async Task<PagedList<CityModel>> GetPagedAsync(CitiesSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var pagedList = await DbSet.Include(c => c.Country)
                .Where(x => (searchObject.SearchFilter == null ||
                x.Name.ToLower().Contains(searchObject.SearchFilter.ToLower())) &&
                (searchObject.CountryId == null || searchObject.CountryId == x.CountryId))
                .ToPagedListAsync(searchObject);
            return Mapper.Map<PagedList<CityModel>>(pagedList);
        }

        public async Task<IEnumerable<CityModel>> GetByCountryIdAsync(int countryId, CancellationToken cancellationToken = default)
        {
            var cities = await DbSet.AsNoTracking().Where(c => c.CountryId == countryId).ToListAsync(cancellationToken);

            return Mapper.Map<IEnumerable<CityModel>>(cities);
        }

        public async Task<IEnumerable<KeyValuePair<int, string>>> GetDropdownItems(int? countryId)
        {
            return await DbSet.Where(c => countryId == null || c.CountryId == countryId).Select(c => new KeyValuePair<int, string>(c.Id, c.Name)).ToListAsync();
        }
    }
}
