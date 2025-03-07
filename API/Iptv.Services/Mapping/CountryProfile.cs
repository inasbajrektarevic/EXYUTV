using Iptv.Core;
using Iptv.Core.Models;

namespace Iptv.Services.Mapping
{
    public class CountryProfile : BaseProfile
    {
        public CountryProfile()
        {
            CreateMap<Country, CountryModel>();
            CreateMap<CountryUpsertModel, Country>().ReverseMap();
        }
    }
}
