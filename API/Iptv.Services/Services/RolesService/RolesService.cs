using AutoMapper;
using FluentValidation;
using Iptv.Core;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services.Database;

namespace Iptv.Services
{
    public class RolesService : BaseService<Role, int, RoleModel, RoleUpsertModel, BaseSearchObject>, IRolesService
    {
        public RolesService(IMapper mapper, IValidator<RoleUpsertModel> validator, DatabaseContext databaseContext) : base(mapper, validator, databaseContext)
        {

        }
    }
}
