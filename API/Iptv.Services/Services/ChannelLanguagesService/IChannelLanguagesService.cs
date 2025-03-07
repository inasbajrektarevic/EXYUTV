using Iptv.Core.Models;
using Iptv.Core.SearchObjects;

namespace Iptv.Services
{
    public interface IChannelLanguagesService : IBaseService<int, ChannelLanguageModel, ChannelLanguageUpsertModel, BaseSearchObject>
    {
        Task<IEnumerable<KeyValuePair<int, string>>> GetDropdownItems();
    }
}
