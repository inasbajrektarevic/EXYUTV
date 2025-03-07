using Iptv.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Iptv.Api
{
    public class DropdownController : BaseController
    {
        private readonly IDropdownService _dropdownService;
        public DropdownController(IDropdownService service, ILogger<DropdownController> logger, IActivityLogsService activityLogs) : base(logger, activityLogs)
        {
            _dropdownService = service;
        }

        [HttpGet]
        [Route("deviceTypes")]
        public async Task<IActionResult> DeviceTypes()
        {
            var list = await _dropdownService.GetDeviceTypesAsync();
            return Ok(list);
        }

        [HttpGet]
        [Route("applications")]
        public async Task<IActionResult> Applications()
        {
            var list = await _dropdownService.GetApplicationsAsync();
            return Ok(list);
        }

        [HttpGet]
        [Route("genders")]
        public async Task<IActionResult> Genders()
        {
            var list = await _dropdownService.GetGendersAsync();
            return Ok(list);
        }

        [HttpGet]
        [Route("cities")]
        public async Task<IActionResult> Cities([FromQuery] int? countryId)
        {
            var list = await _dropdownService.GetCitiesAsync(countryId);
            return Ok(list);
        }

        [HttpGet]
        [Route("countries")]
        public async Task<IActionResult> Countries()
        {
            var list = await _dropdownService.GetCountriesAsync();
            return Ok(list);
        }

        [HttpGet]
        [Route("channelCategories")]
        public async Task<IActionResult> ChannelCategories()
        {
            var list = await _dropdownService.GetChannelCategoriesAsync();
            return Ok(list);
        }

        [HttpGet]
        [Route("channelLanguages")]
        public async Task<IActionResult> ChannelLanguages()
        {
            var list = await _dropdownService.GetChannelLanguagesAsync();
            return Ok(list);
        }


        [HttpGet]
        [Route("packageStatuses")]
        public async Task<IActionResult> PackageStatuses()
        {
            var list = await _dropdownService.GetPackageStatusesAsync();
            return Ok(list);
        }

        [HttpGet]
        [Route("devices")]
        public async Task<IActionResult> Devices()
        {
            var list = await _dropdownService.GetDevicesAsync();
            return Ok(list);
        }

        [HttpGet]
        [Route("orderTypes")]
        public async Task<IActionResult> OrderTypes()
        {
            var list = await _dropdownService.GetOrderTypesAsync();
            return Ok(list);
        }
    }
}
