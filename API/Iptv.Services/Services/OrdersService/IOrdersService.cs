using Iptv.Core;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;

namespace Iptv.Services
{
    public interface IOrdersService : IBaseService<int, OrderModel, OrderUpsertModel, OrdersSearchObject>
    {
        Task<OrderModel> UpdateStatus(int orderId, OrderStatus status, CancellationToken cancellationToken = default);
        Task<int> Count(int? userId = null, CancellationToken cancellationToken = default);
        Task<List<OrderModel>> GetByClientIds(List<int> clientIds);
    }
}
