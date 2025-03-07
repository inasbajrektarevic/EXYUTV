using AutoMapper;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services;
using Microsoft.AspNetCore.Authorization;

namespace Iptv.Api
{
    [Authorize(AuthenticationSchemes = "Bearer")]
    public class DevicesController : BaseCrudController<DeviceModel, DeviceUpsertModel, DevicesSearchObject, IDevicesService>
    {
        public DevicesController(IDevicesService service, IMapper mapper, ILogger<DevicesController> logger, IActivityLogsService activityLogs) : base(service, logger, activityLogs)
        {
        }

    }
}
