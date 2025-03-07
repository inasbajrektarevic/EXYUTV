using AutoMapper;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services;
using Microsoft.AspNetCore.Authorization;

namespace Iptv.Api
{
    [Authorize(AuthenticationSchemes = "Bearer")]
    public class ChannelCategoriesController : BaseCrudController<ChannelCategoryModel, ChannelCategoryUpsertModel, BaseSearchObject, IChannelCategoriesService>
    {
        public ChannelCategoriesController(IChannelCategoriesService service, IMapper mapper, ILogger<ChannelCategoriesController> logger, IActivityLogsService activityLogs) : base(service, logger, activityLogs)
        {
        }

    }
}
