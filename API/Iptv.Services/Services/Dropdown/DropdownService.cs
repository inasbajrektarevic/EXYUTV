using Iptv.Core;

namespace Iptv.Services
{
    public class DropdownService : IDropdownService
    {
        private readonly IDeviceTypesService _deviceTypesService;
        private readonly IApplicationsService _applicationsService;
        private readonly ICountriesService _countriesService;
        private readonly ICitiesService _citiesService;
        private readonly IChannelCategoriesService _channelCategoriesService;
        private readonly IChannelLanguagesService _channelLanguagesService;
        private readonly IDevicesService _devicesService;
        public DropdownService(IDeviceTypesService deviceTypesService, IApplicationsService applicationsService,
            ICountriesService countriesService, ICitiesService citiesService, IChannelCategoriesService channelCategoriesService,
            IChannelLanguagesService channelLanguagesService, IDevicesService devicesService)
        {
            _deviceTypesService = deviceTypesService;
            _applicationsService = applicationsService;
            _countriesService = countriesService;
            _citiesService = citiesService;
            _channelCategoriesService = channelCategoriesService;
            _channelLanguagesService = channelLanguagesService;
            _devicesService = devicesService;
        }

        public async Task<IEnumerable<KeyValuePair<int, string>>> GetGendersAsync() => await Task.FromResult(GetValues<Gender>());
        public async Task<IEnumerable<KeyValuePair<int, string>>> GetPackageStatusesAsync() => await Task.FromResult(GetValues<PackageStatus>());
        public async Task<IEnumerable<KeyValuePair<int, string>>> GetCountriesAsync() => await _countriesService.GetDropdownItems();
        public async Task<IEnumerable<KeyValuePair<int, string>>> GetChannelLanguagesAsync() => await _channelLanguagesService.GetDropdownItems();
        public async Task<IEnumerable<KeyValuePair<int, string>>> GetChannelCategoriesAsync() => await _channelCategoriesService.GetDropdownItems();
        public async Task<IEnumerable<KeyValuePair<int, string>>> GetCitiesAsync(int? countryId) => await _citiesService.GetDropdownItems(countryId);
        public async Task<IEnumerable<KeyValuePair<int, string>>> GetDeviceTypesAsync() => await _deviceTypesService.GetDropdownItems();
        public async Task<IEnumerable<KeyValuePair<int, string>>> GetApplicationsAsync() => await _applicationsService.GetDropdownItems();
        public async Task<IEnumerable<KeyValuePair<int, string>>> GetDevicesAsync() => await _devicesService.GetDropdownItems();
        public async Task<IEnumerable<KeyValuePair<int, string>>> GetOrderTypesAsync() => await Task.FromResult(GetValues<OrderType>());

        private IEnumerable<KeyValuePair<int, string>> GetValues<T>() where T : Enum
        {
            return Enum.GetValues(typeof(T))
                       .Cast<int>()
                       .Select(e => new KeyValuePair<int, string>(e, Enum.GetName(typeof(T), e)!));
        }
    }
}
