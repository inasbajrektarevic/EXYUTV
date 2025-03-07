namespace Iptv.Core.Models
{
    public class ChannelCategoryModel : BaseModel
    {
        public string Name { get; set; } = default!;
        public bool IsActive { get; set; }
        public string Description { get; set; } = default!;
        public int OrderNumber { get; set; }
        public ICollection<ChannelModel> Channels { get; set; } = [];
    }
}
