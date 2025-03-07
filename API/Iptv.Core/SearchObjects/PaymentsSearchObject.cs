namespace Iptv.Core.SearchObjects
{
    public class PaymentsSearchObject : BaseSearchObject
    {
        public int? UserId { get; set; }
        public int? OrderId { get; set; }
        public int? Status { get; set; }
    }
}
