using Iptv.Core;
using Iptv.Core.Models;

namespace Iptv.Services.Mapping
{
    public class CityProfile : BaseProfile
    {
        public CityProfile()
        {
            CreateMap<City, CityModel>().ReverseMap();
            CreateMap<City, CityUpsertModel>().ReverseMap();
        }
    }
}
