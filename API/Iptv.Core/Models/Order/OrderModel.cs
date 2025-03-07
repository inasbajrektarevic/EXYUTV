namespace Iptv.Core.Models
{
    public class OrderModel : BaseModel
    {
        public string Name { get; set; } = default!;
        public OrderType Type { get; set; } = default!;
        public OrderStatus Status { get; set; } = default!;
        public DateTime DateFrom { get; set; }
        public DateTime? DateTo { get; set; }
        public string Note { get; set; } = default!;
        public decimal Price { get; set; }
        public decimal? Discount { get; set; }
        public decimal TotalPrice { get; set; }
        public int PackageId { get; set; }
        public PackageModel Package { get; set; } = default!;
        public int UserId { get; set; }
        public UserModel User { get; set; }
    }
}
