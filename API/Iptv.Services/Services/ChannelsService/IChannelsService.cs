using Iptv.Core.Models;
using Iptv.Core.SearchObjects;

namespace Iptv.Services
{
    public interface IChannelsService : IBaseService<int, ChannelModel, ChannelUpsertModel, ChannelsSearchObject>
    {
        Task<int> Count(CancellationToken cancellationToken = default);
    }
}
