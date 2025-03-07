namespace Iptv.Core.Models
{
    public class ChannelModel : BaseModel
    {
        public string Name { get; set; } = default!;
        public float Frequency { get; set; }
        public string LogoUrl { get; set; } = default!;
        public string Description { get; set; } = default!;
        public bool IsHD { get; set; }
        public int ChannelCategoryId { get; set; }
        public ChannelCategoryModel ChannelCategory { get; set; } = default!;
        public int CountryId { get; set; }
        public CountryModel Country { get; set; } = default!;
        public int ChannelLanguageId { get; set; } = default!;
        public ChannelLanguageModel ChannelLanguage { get; set; } = default!;
        public string StreamUrl { get; set; } = default!;
        public int ChannelNumber { get; set; }
        public string Owner { get; set; } = default!;
    }
}
