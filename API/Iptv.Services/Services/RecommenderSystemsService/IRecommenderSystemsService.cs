using Iptv.Core.Models;

namespace Iptv.Services
{
    public interface IRecommenderSystemsService
    {
        Task<List<EntityItemModel>> RecommendPackagesAsync(int clientId);
    }
}
