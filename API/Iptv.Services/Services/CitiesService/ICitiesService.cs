using Iptv.Core.Models;
using Iptv.Core.SearchObjects;

namespace Iptv.Services
{
    public interface ICitiesService : IBaseService<int, CityModel, CityUpsertModel, CitiesSearchObject>
    {
        Task<IEnumerable<CityModel>> GetByCountryIdAsync(int countryId, CancellationToken cancellationToken = default);
        Task<IEnumerable<KeyValuePair<int, string>>> GetDropdownItems(int? countryId);
    }
}
