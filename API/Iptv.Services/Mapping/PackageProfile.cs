using Iptv.Core;
using Iptv.Core.Models;

namespace Iptv.Services.Mapping
{
    public class PackageProfile : BaseProfile
    {
        public PackageProfile()
        {
            CreateMap<Package, PackageModel>().ReverseMap();
            CreateMap<Package, PackageUpsertModel>().ReverseMap();
        }
    }
}
