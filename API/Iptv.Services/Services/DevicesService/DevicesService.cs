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
    public class DevicesService : BaseService<Device, int, DeviceModel, DeviceUpsertModel, DevicesSearchObject>, IDevicesService
    {
        public DevicesService(IMapper mapper, IValidator<DeviceUpsertModel> validator, DatabaseContext databaseContext) : base(mapper, validator, databaseContext)
        {

        }

        public override async Task<PagedList<DeviceModel>> GetPagedAsync(DevicesSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var pagedList = await DbSet.Include(x => x.DeviceType)
                .Where(x => (searchObject.SearchFilter == null ||
                x.Name.ToLower().Contains(searchObject.SearchFilter.ToLower())) &&
                (searchObject.DeviceTypeId == null || searchObject.DeviceTypeId == x.DeviceTypeId))
                .ToPagedListAsync(searchObject);
            return Mapper.Map<PagedList<DeviceModel>>(pagedList);
        }
        public async Task<IEnumerable<KeyValuePair<int, string>>> GetDropdownItems()
        {
            return await DbSet.Select(a => new KeyValuePair<int, string>(a.Id, a.Name)).ToListAsync();
        }
    }
}
