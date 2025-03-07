using Iptv.Core;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;

namespace Iptv.Services
{
    public interface IDailyPackageRequestsService : IBaseService<int, DailyPackageRequestModel, DailyPackageRequestUpsertModel, DailyPackageRequestsSearchObject>
    {
        Task<DailyPackageRequestModel> UpdateStatus(int id, UserPackageRequestStatus status, CancellationToken cancellationToken = default);
    }
}
