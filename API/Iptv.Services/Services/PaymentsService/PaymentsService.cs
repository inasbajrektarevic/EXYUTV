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
    public class PaymentsService : BaseService<Payment, int, PaymentModel, PaymentUpsertModel, PaymentsSearchObject>, IPaymentsService
    {
        public PaymentsService(IMapper mapper, IValidator<PaymentUpsertModel> validator, DatabaseContext databaseContext) : base(mapper, validator, databaseContext)
        {

        }
        public override async Task<PagedList<PaymentModel>> GetPagedAsync(PaymentsSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var pagedList = await DbSet
                .Include(x => x.User)
                .Include(x => x.Order)
                .Where(x => (searchObject.SearchFilter == null || x.TransactionId.Contains(searchObject.SearchFilter.ToLower())) &&
                 (searchObject.UserId == null || x.UserId == searchObject.UserId) &&
                 (searchObject.OrderId == null || x.OrderId == searchObject.OrderId) &&
                 (searchObject.Status == null || (int)x.Status! == searchObject.Status))
                .ToPagedListAsync(searchObject);
            return Mapper.Map<PagedList<PaymentModel>>(pagedList);
        }

        public async Task<List<PaymentModel>> AddPayments(int userId, CancellationToken cancellationToken = default)
        {
            var orders = await DatabaseContext.Orders.Where(o => (o.Status == OrderStatus.Confirmed || o.Status == OrderStatus.Completed) && o.UserId == userId).ToListAsync();

            var orderIds = orders.Select(x => x.Id);
            var createdPayments = await DatabaseContext.Payments.Where(p => orderIds.Contains(p.OrderId)).ToListAsync();

            var paymentsForAdd = new List<Payment>();

            foreach (var order in orders)
            {
                if (!createdPayments.Any(p => p.OrderId == order.Id && p.DateFrom == order.DateFrom && p.DateTo == order.DateTo))
                {
                    var payment = new Payment
                    {
                        DateFrom = order.DateFrom,
                        DateTo = order.DateTo!.Value,
                        Discount = order.Discount,
                        Note = order.Note,
                        OrderId = order.Id,
                        Price = order.TotalPrice,
                        Status = StatusPayment.During,
                        UserId = order.UserId,
                        TransactionId = string.Empty
                    };

                    paymentsForAdd.Add(payment);
                }
            }

            await DatabaseContext.Payments.AddRangeAsync(paymentsForAdd);
            await DatabaseContext.SaveChangesAsync(cancellationToken);

            return Mapper.Map<List<PaymentModel>>(paymentsForAdd);
        }

        public async Task<PaymentModel> SetIsPaid(int paymentId, string transactionId, CancellationToken cancellationToken = default)
        {
            var payment = await DbSet.FirstOrDefaultAsync(o => o.Id == paymentId);

            if (payment == null)
            {
                throw new Exception("Payment not found");
            }
            payment.Status = StatusPayment.Approved;
            payment.IsPaid = true;
            payment.TransactionId = transactionId;

            DbSet.Update(payment);

            await DatabaseContext.SaveChangesAsync(cancellationToken);
            return Mapper.Map<PaymentModel>(payment);
        }
    }
}
