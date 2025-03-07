using Iptv.Core;
using Iptv.Core.Models;

namespace Iptv.Services.Mapping
{
    public class ChannelCategoryProfile : BaseProfile
    {
        public ChannelCategoryProfile()
        {
            CreateMap<ChannelCategory, ChannelCategoryModel>().ReverseMap();
            CreateMap<ChannelCategory, ChannelCategoryUpsertModel>().ReverseMap();
        }
    }
}
