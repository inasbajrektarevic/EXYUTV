namespace Iptv.Core
{
    public class Payment : BaseEntity
    {
        public bool IsPaid { get; set; }
        public DateTime DateFrom { get; set; }
        public DateTime DateTo { get; set; }
        public int OrderId { get; set; }
        public Order Order { get; set; } = default!;
        public int UserId { get; set; }
        public User User { get; set; } = default!;
        public decimal Price { get; set; }
        public decimal? Discount { get; set; }
        public string? Note { get; set; }
        public StatusPayment? Status { get; set; }
        public string TransactionId { get; set; } = default!;
    }
}
