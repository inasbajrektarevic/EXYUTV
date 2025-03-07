using Iptv.Core;
using Iptv.Core.Models;

namespace Iptv.Services.Mapping
{
    public class DeviceProfile : BaseProfile
    {
        public DeviceProfile()
        {
            CreateMap<Device, DeviceModel>().ReverseMap();
            CreateMap<Device, DeviceUpsertModel>().ReverseMap();
        }
    }
}
