using AutoMapper;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services;
using Microsoft.AspNetCore.Authorization;

namespace Iptv.Api
{
    [Authorize(AuthenticationSchemes = "Bearer")]
    public class ChannelLanguagesController : BaseCrudController<ChannelLanguageModel, ChannelLanguageUpsertModel, BaseSearchObject, IChannelLanguagesService>
    {
        public ChannelLanguagesController(IChannelLanguagesService service, IMapper mapper, ILogger<ChannelLanguagesController> logger, IActivityLogsService activityLogs) : base(service, logger, activityLogs)
        {
        }

    }
}
