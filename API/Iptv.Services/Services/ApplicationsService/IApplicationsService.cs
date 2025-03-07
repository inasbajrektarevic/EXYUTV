using Iptv.Core.Models;
using Iptv.Core.SearchObjects;

namespace Iptv.Services
{
    public interface IApplicationsService : IBaseService<int, ApplicationModel, ApplicationUpsertModel, BaseSearchObject>
    {
        Task<IEnumerable<KeyValuePair<int, string>>> GetDropdownItems();
    }
}
