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
    public class OrdersService : BaseService<Order, int, OrderModel, OrderUpsertModel, OrdersSearchObject>, IOrdersService
    {
        private readonly IPaymentsService _paymentsService;
        public OrdersService(IMapper mapper, IPaymentsService paymentsService, IValidator<OrderUpsertModel> validator, DatabaseContext databaseContext) : base(mapper, validator, databaseContext)
        {
            _paymentsService = paymentsService;
        }

        public override async Task<PagedList<OrderModel>> GetPagedAsync(OrdersSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var pagedList = await DbSet
                .Include(x => x.Package).ThenInclude(x => x.ChannelCategories).ThenInclude(x => x.ChannelCategory)
                .Include(x => x.User)
                .Where(x => (searchObject.SearchFilter == null ||
                x.Name.ToLower().Contains(searchObject.SearchFilter.ToLower())) &&
                (searchObject.UserId == null || x.UserId == searchObject.UserId) &&
                (searchObject.PackageId == null || x.PackageId == searchObject.PackageId))
                .ToPagedListAsync(searchObject);
            return Mapper.Map<PagedList<OrderModel>>(pagedList);
        }

        public override async Task<OrderModel> AddAsync(OrderUpsertModel model, CancellationToken cancellationToken = default)
        {
            var countOfOrders = DatabaseContext.Orders.Count() + 1;
            model.Name = $"O/{countOfOrders}/{DateTime.Now.Year}";
            model.DateFrom = model.DateTo = DateTime.Now;
            model.Status = OrderStatus.Processing;

            var entity = Mapper.Map<Order>(model);
            entity.Id = default;

            await DbSet.AddAsync(entity, cancellationToken);
            await DatabaseContext.SaveChangesAsync(cancellationToken);

            return Mapper.Map<OrderModel>(entity);
        }

        public async Task<List<OrderModel>> GetByClientIds(List<int> clientIds)
        {
            var entities = await DbSet.Where(x => clientIds.Any(y => y == x.UserId)).ToListAsync();

            return Mapper.Map<List<OrderModel>>(entities);
        }

        public async Task<OrderModel> UpdateStatus(int orderId, OrderStatus status, CancellationToken cancellationToken = default)
        {
            var order = await DbSet.FirstOrDefaultAsync(o => o.Id == orderId);

            if (order == null)
            {
                throw new Exception("Order not found");
            }

            order.Status = status;
            if (status == OrderStatus.Confirmed)
            {
                order.DateFrom = DateTime.Now;

                if (order.Type == OrderType.Mjesečna)
                {
                    order.DateTo = order.DateFrom.AddMonths(1);
                }
            }

            DbSet.Update(order);
            await DatabaseContext.SaveChangesAsync(cancellationToken);

            await _paymentsService.AddPayments(order.UserId);

            return Mapper.Map<OrderModel>(order);
        }

        public Task<int> Count(int? userId = null, CancellationToken cancellationToken = default)
        {
            return DbSet.Where(x => x.IsDeleted == false && (userId == null || x.UserId == userId)
            && (x.Status == OrderStatus.Confirmed || x.Status == OrderStatus.Completed || x.Status == OrderStatus.Processing)).CountAsync(cancellationToken);
        }
    }
}
