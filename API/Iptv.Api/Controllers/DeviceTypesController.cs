using AutoMapper;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services;
using Microsoft.AspNetCore.Authorization;

namespace Iptv.Api
{
    [Authorize(AuthenticationSchemes = "Bearer")]
    public class DeviceTypesController : BaseCrudController<DeviceTypeModel, DeviceTypeUpsertModel, BaseSearchObject, IDeviceTypesService>
    {
        public DeviceTypesController(IDeviceTypesService service, IMapper mapper, ILogger<DeviceTypesController> logger, IActivityLogsService activityLogs) : base(service, logger, activityLogs)
        {
        }

    }
}
