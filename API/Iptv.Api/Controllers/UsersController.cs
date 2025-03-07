using AutoMapper;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services;
using Microsoft.AspNetCore.Authorization;

namespace Iptv.Api
{
    [Authorize(AuthenticationSchemes = "Bearer")]
    public class UsersController : BaseCrudController<UserModel, UserUpsertModel, UsersSearchObject, IUsersService>
    {
        public UsersController(IUsersService service, IMapper mapper, ILogger<UsersController> logger, IActivityLogsService activityLogs) : base(service, logger, activityLogs)
        {
        }

    }
}
