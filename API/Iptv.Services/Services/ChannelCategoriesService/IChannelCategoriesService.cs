using Iptv.Core.Models;
using Iptv.Core.SearchObjects;

namespace Iptv.Services
{
    public interface IChannelCategoriesService : IBaseService<int, ChannelCategoryModel, ChannelCategoryUpsertModel, BaseSearchObject>
    {
        Task<IEnumerable<KeyValuePair<int, string>>> GetDropdownItems();
        Task<int> Count(CancellationToken cancellationToken = default);
    }
}
