using AutoMapper;
using Iptv.Api.Controllers;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services;
using Microsoft.AspNetCore.Authorization;

namespace Iptv.Api
{
    [Authorize(AuthenticationSchemes = "Bearer")]
    public class CountriesController : BaseCrudController<CountryModel, CountryUpsertModel, BaseSearchObject, ICountriesService>
    {
        public CountriesController(ICountriesService service, IMapper mapper, ILogger<CitiesController> logger, IActivityLogsService activityLogs) : base(service, logger, activityLogs)
        {
        }

    }
}
