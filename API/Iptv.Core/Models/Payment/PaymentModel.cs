namespace Iptv.Core.Models
{
    public class PaymentModel : BaseModel
    {
        public bool IsPaid { get; set; }
        public DateTime DateFrom { get; set; }
        public DateTime DateTo { get; set; }
        public int OrderId { get; set; }
        public OrderModel Order { get; set; } = default!;
        public int UserId { get; set; }
        public UserModel User { get; set; } = default!;
        public decimal Price { get; set; }
        public decimal? Discount { get; set; }
        public string? Note { get; set; }
        public StatusPayment? Status { get; set; }
        public string TransactionId { get; set; } = default!;
    }
}
