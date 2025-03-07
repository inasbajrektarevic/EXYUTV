using Microsoft.AspNetCore.Http;

namespace Iptv.Core.Models
{
    public class ChannelUpsertModel : BaseUpsertModel
    {
        public string Name { get; set; } = default!;
        public float Frequency { get; set; }
        public string? LogoUrl { get; set; } = default!;
        public IFormFile? LogoFile { get; set; } = default!;
        public string Description { get; set; } = default!;
        public bool IsHD { get; set; }
        public int ChannelCategoryId { get; set; }
        public int CountryId { get; set; }
        public int ChannelLanguageId { get; set; }
        public string StreamUrl { get; set; } = default!;
        public int ChannelNumber { get; set; }
        public string Owner { get; set; } = default!;
    }
}
