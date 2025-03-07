namespace Iptv.Core
{
    public class ChannelLanguage : BaseEntity
    {
        public string Name { get; set; } = default!;
        public string CultureName { get; set; } = default!;
        public bool IsActive { get; set; }
    }
}
