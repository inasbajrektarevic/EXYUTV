using Iptv.Core;
using Iptv.Core.Models;

namespace Iptv.Services.Mapping
{
    public class RoleProfile : BaseProfile
    {
        public RoleProfile()
        {
            CreateMap<Role, RoleModel>().ReverseMap();
            CreateMap<Role, RoleUpsertModel>().ReverseMap();
        }
    }
}
