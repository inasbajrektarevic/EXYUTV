namespace Iptv.Core
{
    public class Channel : BaseEntity
    {
        public string Name { get; set; } = default!;
        public float Frequency { get; set; }
        public string? LogoUrl { get; set; }
        public string Description { get; set; } = default!;
        public bool IsHD { get; set; }
        public int ChannelCategoryId { get; set; }
        public ChannelCategory ChannelCategory { get; set; } = default!;
        public int CountryId { get; set; }
        public Country Country { get; set; } = default!;
        public int ChannelLanguageId { get; set; } = default!;
        public ChannelLanguage ChannelLanguage { get; set; } = default!;
        public string StreamUrl { get; set; } = default!;
        public int ChannelNumber { get; set; }
        public string Owner { get; set; } = default!;
    }
}
