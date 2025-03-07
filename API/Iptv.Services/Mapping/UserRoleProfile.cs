using Iptv.Core;
using Iptv.Core.Models;
using Iptv.Shared;

namespace Iptv.Services.Mapping
{
    public class UserRoleProfile : BaseProfile
    {
        public UserRoleProfile()
        {
            CreateMap<UserRole, UserRoleModel>().ReverseMap();
            CreateMap<UserRole, UserRoleUpsertModel>().ReverseMap();
            CreateMap<User, UserLoginDataModel>();
            CreateMap<UserLoginDataModel, LoginInformationModel>()
                .ForPath(x => x.UserId, opt => opt.MapFrom(x => x.Id))
                .ForMember(x => x.UserName, opt => opt.MapFrom(x => !string.IsNullOrWhiteSpace(x.UserName) ? x.UserName : x.Email));
        }
    }
}
