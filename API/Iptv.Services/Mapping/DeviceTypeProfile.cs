using Iptv.Core;
using Iptv.Core.Models;

namespace Iptv.Services.Mapping
{
    public class DeviceTypeProfile : BaseProfile
    {
        public DeviceTypeProfile()
        {
            CreateMap<DeviceType, DeviceTypeModel>().ReverseMap();
            CreateMap<DeviceType, DeviceTypeUpsertModel>().ReverseMap();
        }
    }
}
