namespace Iptv.Core
{
    public class PackageChannelCategory : BaseEntity
    {
        public int ChannelCategoryId { get; set; }
        public ChannelCategory ChannelCategory { get; set; } = default!;
        public int PackageId { get; set; }
    }
}
