using Iptv.Core;
using Iptv.Core.Models;
using Iptv.Shared;

namespace Iptv.Services.Mapping
{
    public class UserProfile : BaseProfile
    {
        public UserProfile()
        {
            CreateMap<User, UserModel>().ReverseMap();
            CreateMap<User, UserUpsertModel>().ReverseMap();
        }
    }
}
