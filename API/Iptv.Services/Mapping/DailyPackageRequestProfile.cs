using Iptv.Core;
using Iptv.Core.Models;

namespace Iptv.Services.Mapping
{
    public class DailyPackageRequestProfile : BaseProfile
    {
        public DailyPackageRequestProfile()
        {
            CreateMap<DailyPackageRequest, DailyPackageRequestModel>().ReverseMap();
            CreateMap<DailyPackageRequest, DailyPackageRequestUpsertModel>().ReverseMap();
        }
    }
}
