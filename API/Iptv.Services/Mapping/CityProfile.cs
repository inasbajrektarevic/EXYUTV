using Iptv.Core;
using Iptv.Core.Models;

namespace Iptv.Services.Mapping
{
    public class ApplicationProfile : BaseProfile
    {
        public ApplicationProfile()
        {
            CreateMap<Application, ApplicationModel>().ReverseMap();
            CreateMap<Application, ApplicationUpsertModel>().ReverseMap();
        }
    }
}
