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
    public class DeviceTypesService : BaseService<DeviceType, int, DeviceTypeModel, DeviceTypeUpsertModel, BaseSearchObject>, IDeviceTypesService
    {
        public DeviceTypesService(IMapper mapper, IValidator<DeviceTypeUpsertModel> validator, DatabaseContext databaseContext) : base(mapper, validator, databaseContext)
        {

        }

        public override async Task<PagedList<DeviceTypeModel>> GetPagedAsync(BaseSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var pagedList = await DbSet
                .Where(x => searchObject.SearchFilter == null ||
                x.Name.ToLower().Contains(searchObject.SearchFilter.ToLower()))
                .ToPagedListAsync(searchObject);
            return Mapper.Map<PagedList<DeviceTypeModel>>(pagedList);
        }

        public async Task<IEnumerable<KeyValuePair<int, string>>> GetDropdownItems()
        {
            return await DbSet.Select(dt => new KeyValuePair<int, string>(dt.Id, dt.Name)).ToListAsync();
        }

        public Task<int> Count(CancellationToken cancellationToken = default)
        {
            return DbSet.Where(x => x.IsDeleted == false).CountAsync(cancellationToken);
        }
    }
}
