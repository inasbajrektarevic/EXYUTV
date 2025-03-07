namespace Iptv.Services
{
    public interface IDropdownService
    {
        Task<IEnumerable<KeyValuePair<int, string>>> GetGendersAsync();
        Task<IEnumerable<KeyValuePair<int, string>>> GetPackageStatusesAsync();
        Task<IEnumerable<KeyValuePair<int, string>>> GetCountriesAsync();
        Task<IEnumerable<KeyValuePair<int, string>>> GetCitiesAsync(int? countryId = null);
        Task<IEnumerable<KeyValuePair<int, string>>> GetApplicationsAsync();
        Task<IEnumerable<KeyValuePair<int, string>>> GetDeviceTypesAsync();
        Task<IEnumerable<KeyValuePair<int, string>>> GetChannelCategoriesAsync();
        Task<IEnumerable<KeyValuePair<int, string>>> GetChannelLanguagesAsync();
        Task<IEnumerable<KeyValuePair<int, string>>> GetDevicesAsync();
        Task<IEnumerable<KeyValuePair<int, string>>> GetOrderTypesAsync();
    }
}