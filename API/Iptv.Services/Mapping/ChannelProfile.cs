using Iptv.Core;
using Iptv.Core.Models;

namespace Iptv.Services.Mapping
{
    public class ChannelProfile : BaseProfile
    {
        public ChannelProfile()
        {
            CreateMap<Channel, ChannelModel>().ReverseMap();
            CreateMap<ChannelUpsertModel, Channel>();
        }
    }
}
