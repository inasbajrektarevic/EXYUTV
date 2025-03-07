using Iptv.Core.Models;
using Iptv.Core.SearchObjects;

namespace Iptv.Services
{
    public interface IPackagesService : IBaseService<int, PackageModel, PackageUpsertModel, PackagesSearchObject>
    {
        Task<int> Count(CancellationToken cancellationToken = default);
        Task<List<EntityItemModel>> GetActivePackages();
    }
}
