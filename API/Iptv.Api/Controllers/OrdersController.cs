using AutoMapper;
using Iptv.Core;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Iptv.Api
{
    [Authorize(AuthenticationSchemes = "Bearer")]
    public class OrdersController : BaseCrudController<OrderModel, OrderUpsertModel, OrdersSearchObject, IOrdersService>
    {
        public OrdersController(IOrdersService service, IMapper mapper, ILogger<OrdersController> logger, IActivityLogsService activityLogs) : base(service, logger, activityLogs)
        {
        }

        [HttpPost]
        public override async Task<IActionResult> Post([FromBody] OrderUpsertModel model, CancellationToken cancellationToken = default)
        {
            try
            {
                var result = await Service.AddAsync(model, cancellationToken);
                return Ok(result);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when posting resource");
                return BadRequest();
            }
        }

        [HttpPost("updateStatus/{orderId}")]
        public async Task<IActionResult> UpdateStatus(int orderId, OrderStatus status, CancellationToken cancellationToken = default)
        {
            try
            {
                var result = await Service.UpdateStatus(orderId, status, cancellationToken);
                return Ok(result);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when update order status");
                return BadRequest();
            }
        }
    }
}
