using AutoMapper;
using Iptv.Core;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Iptv.Api
{
    [Authorize(AuthenticationSchemes = "Bearer")]
    public class DailyPackageRequestsController : BaseCrudController<DailyPackageRequestModel, DailyPackageRequestUpsertModel, DailyPackageRequestsSearchObject, IDailyPackageRequestsService>
    {
        public DailyPackageRequestsController(IDailyPackageRequestsService service, IMapper mapper, ILogger<DailyPackageRequestsController> logger, IActivityLogsService activityLogs) : base(service, logger, activityLogs)
        {
        }

        [HttpPost("updateStatus/{requestId}")]
        public async Task<IActionResult> UpdateStatus(int requestId, UserPackageRequestStatus status, CancellationToken cancellationToken = default)
        {
            try
            {
                var result = await Service.UpdateStatus(requestId, status, cancellationToken);
                return Ok(result);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when update daily package request status");
                return BadRequest();
            }
        }
    }
}
