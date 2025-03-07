using AutoMapper;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services;
using Microsoft.AspNetCore.Authorization;

namespace Iptv.Api
{
    [Authorize(AuthenticationSchemes = "Bearer")]
    public class ApplicationsController : BaseCrudController<ApplicationModel, ApplicationUpsertModel, BaseSearchObject, IApplicationsService>
    {
        public ApplicationsController(IApplicationsService service, IMapper mapper, ILogger<ApplicationsController> logger, IActivityLogsService activityLogs) : base(service, logger, activityLogs)
        {
        }

    }
}
