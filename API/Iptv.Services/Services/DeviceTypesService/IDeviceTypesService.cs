using Iptv.Core.Models;
using Iptv.Core.SearchObjects;

namespace Iptv.Services
{
    public interface IDeviceTypesService : IBaseService<int, DeviceTypeModel, DeviceTypeUpsertModel, BaseSearchObject>
    {
        Task<IEnumerable<KeyValuePair<int, string>>> GetDropdownItems();
        Task<int> Count(CancellationToken cancellationToken = default);
    }
}
