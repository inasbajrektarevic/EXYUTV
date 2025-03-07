namespace Iptv.Core.Models
{
    public class ChannelCategoryUpsertModel : BaseUpsertModel
    {
        public string Name { get; set; } = default!;
        public bool IsActive { get; set; }
        public string Description { get; set; } = default!;
        public int OrderNumber { get; set; }
    }
}
