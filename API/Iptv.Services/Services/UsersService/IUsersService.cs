using Iptv.Core.Models;
using Iptv.Core.SearchObjects;

namespace Iptv.Services
{
    public interface IUsersService : IBaseService<int, UserModel, UserUpsertModel, UsersSearchObject>
    {
        Task<UserLoginDataModel?> FindByUserNameOrEmailAsync(string userName, CancellationToken cancellationToken = default);
        Task<int> ClientCount(CancellationToken cancellationToken = default);
        Task<Dictionary<DateTime, int>> GetDailyClientRegistrationsAsync(CancellationToken cancellationToken = default);
        Task<List<UserModel>> GetClientByBirthDateRange(int yearFrom, int yearTo);
    }
}
