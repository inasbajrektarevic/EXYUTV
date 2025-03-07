using Iptv.Core;
using Iptv.Core.Models;

namespace Iptv.Services.Mapping
{
    public class ChannelLanguageProfile : BaseProfile
    {
        public ChannelLanguageProfile()
        {
            CreateMap<ChannelLanguage, ChannelLanguageModel>().ReverseMap();
            CreateMap<ChannelLanguage, ChannelLanguageUpsertModel>().ReverseMap();
        }
    }
}
