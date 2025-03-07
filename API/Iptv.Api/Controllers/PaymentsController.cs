using AutoMapper;
using Iptv.Core.Models;
using Iptv.Core.SearchObjects;
using Iptv.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Iptv.Api
{
    [Authorize(AuthenticationSchemes = "Bearer")]
    public class PaymentsController : BaseCrudController<PaymentModel, PaymentUpsertModel, PaymentsSearchObject, IPaymentsService>
    {
        public PaymentsController(IPaymentsService service, IMapper mapper, ILogger<PaymentsController> logger, IActivityLogsService activityLogs) : base(service, logger, activityLogs)
        {
        }

        [HttpPost("SetIsPaid/{paymentId}/{transactionId}")]
        public async Task<IActionResult> SetIsPaid(int paymentId, string transactionId, CancellationToken cancellationToken = default)
        {
            try
            {
                var result = await Service.SetIsPaid(paymentId, transactionId, cancellationToken);
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
