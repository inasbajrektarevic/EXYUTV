using Iptv.Core.Models;
using Iptv.Core.SearchObjects;

namespace Iptv.Services
{
    public interface IDevicesService : IBaseService<int, DeviceModel, DeviceUpsertModel, DevicesSearchObject>
    {
        Task<IEnumerable<KeyValuePair<int, string>>> GetDropdownItems();
    }
}
