using Iptv.Core.Models;
using Iptv.Core.SearchObjects;

namespace Iptv.Services
{
    public interface IRolesService : IBaseService<int, RoleModel, RoleUpsertModel, BaseSearchObject>
    {
    }
}
