using Iptv.Core;
using Iptv.Core.Models;

namespace Iptv.Services.Mapping
{
    public class RegistrationProfile : BaseProfile
    {
        public RegistrationProfile()
        {
            CreateMap<RegistrationModel, UserUpsertModel>().ReverseMap();
        }
    }
}
