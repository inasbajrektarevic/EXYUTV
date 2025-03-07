namespace Iptv.Core.Models
{
    public class ChannelLanguageModel : BaseModel
    {
        public string Name { get; set; } = default!;
        public string CultureName { get; set; } = default!;
        public bool IsActive { get; set; }
    }
}
