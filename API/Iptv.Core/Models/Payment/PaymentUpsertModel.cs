namespace Iptv.Core.Models
{
    public class PaymentUpsertModel : BaseUpsertModel
    {
        public bool IsPaid { get; set; }
        public DateTime DateFrom { get; set; }
        public DateTime DateTo { get; set; }
        public int OrderId { get; set; }
        public int UserId { get; set; }
        public decimal Price { get; set; }
        public float? Discount { get; set; }
        public string? Note { get; set; }
        public StatusPayment? Status { get; set; }
    }
}
