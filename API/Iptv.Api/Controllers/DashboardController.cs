using AutoMapper;
using Iptv.Core;
using Iptv.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Iptv.Api
{
    [Authorize(AuthenticationSchemes = "Bearer")]
    public class DashboardController : BaseController
    {
        private readonly IChannelsService _channelsService;
        private readonly IChannelCategoriesService _channelCategoriesService;
        private readonly IPackagesService _packagesService;
        private readonly IOrdersService _ordersService;
        private readonly IDeviceTypesService _deviceTypesService;
        private readonly IUsersService _usersService;
        public DashboardController(IChannelsService channelsService, IChannelCategoriesService channelCategoriesService,
            IPackagesService packagesService, IOrdersService ordersService, IDeviceTypesService deviceTypesService,
            IUsersService usersService, IApplicationsService service, IMapper mapper, ILogger<ApplicationsController> logger, IActivityLogsService activityLogs) : base(logger, activityLogs)
        {
            _channelsService = channelsService;
            _channelCategoriesService = channelCategoriesService;
            _packagesService = packagesService;
            _ordersService = ordersService;
            _deviceTypesService = deviceTypesService;
            _usersService = usersService;
        }

        [HttpGet("Admin")]
        public async Task<IActionResult> GetAdminData(CancellationToken cancellationToken = default)
        {
            try
            {
                var channelsCount = await _channelsService.Count(cancellationToken);
                var channelCategoriesCount = await _channelCategoriesService.Count(cancellationToken);
                var ordersCount = await _ordersService.Count();
                var packagesCount = await _packagesService.Count(cancellationToken);
                var deviceTypesCount = await _deviceTypesService.Count(cancellationToken);
                var clientCounts = await _usersService.ClientCount(cancellationToken);
                var lastSevenDaysRegistrationClients = await _usersService.GetDailyClientRegistrationsAsync(cancellationToken);

                return Ok(new
                {
                    Channels = channelsCount,
                    ChannelCategories = channelCategoriesCount,
                    Orders = ordersCount,
                    Packages = packagesCount,
                    DeviceTypes = deviceTypesCount,
                    Clients = clientCounts,
                    LastSevenDaysRegistrationClients = lastSevenDaysRegistrationClients
                });
            }
            catch (Exception e)
            {
                await ActivityLogs.LogAsync(ActivityLogType.SystemError, "Dashboard", e);
                return BadRequest();
            }
        }

        [HttpGet("Client")]
        public async Task<IActionResult> GetClientData(int userId, CancellationToken cancellationToken = default)
        {
            try
            {
                var channelsCount = await _channelsService.Count(cancellationToken);
                var channelCategoriesCount = await _channelCategoriesService.Count(cancellationToken);
                var ordersCount = await _ordersService.Count(userId, cancellationToken);
                var packagesCount = await _packagesService.Count(cancellationToken);
                return Ok(new
                {
                    Channels = channelsCount,
                    ChannelCategories = channelCategoriesCount,
                    Orders = ordersCount,
                    Packages = packagesCount
                });
            }
            catch (Exception e)
            {
                await ActivityLogs.LogAsync(ActivityLogType.SystemError, "Dashboard", e);
                return BadRequest();
            }
        }
    }
}
