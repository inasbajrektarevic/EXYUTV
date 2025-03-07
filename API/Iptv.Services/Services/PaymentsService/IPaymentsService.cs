using Iptv.Core.Models;
using Iptv.Core.SearchObjects;

namespace Iptv.Services
{
    public interface IPaymentsService : IBaseService<int, PaymentModel, PaymentUpsertModel, PaymentsSearchObject>
    {
        Task<List<PaymentModel>> AddPayments(int userId, CancellationToken cancellationToken = default);
        Task<PaymentModel> SetIsPaid(int paymentId, string transactionId, CancellationToken cancellationToken = default);
    }
}
