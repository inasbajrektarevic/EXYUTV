using AutoMapper;
using FluentValidation;
using Iptv.Core;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services.Database;
using Iptv.Services.Extensions;
using Microsoft.EntityFrameworkCore;

namespace Iptv.Services
{
    public class ApplicationsService : BaseService<Application, int, ApplicationModel, ApplicationUpsertModel, BaseSearchObject>, IApplicationsService
    {
        public ApplicationsService(IMapper mapper, IValidator<ApplicationUpsertModel> validator, DatabaseContext databaseContext) : base(mapper, validator, databaseContext)
        {

        }

        public override async Task<PagedList<ApplicationModel>> GetPagedAsync(BaseSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var pagedList = await DbSet
                .Where(x => searchObject.SearchFilter == null ||
                x.Name.ToLower().Contains(searchObject.SearchFilter.ToLower()))
                .ToPagedListAsync(searchObject);
            return Mapper.Map<PagedList<ApplicationModel>>(pagedList);
        }

        public async Task<IEnumerable<KeyValuePair<int, string>>> GetDropdownItems()
        {
            return await DbSet.Select(a => new KeyValuePair<int, string>(a.Id, a.Name)).ToListAsync();
        }
    }
}
