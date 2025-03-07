namespace Iptv.Core.Models
{
    public class ChannelLanguageUpsertModel : BaseUpsertModel
    {
        public string Name { get; set; } = default!;
        public string CultureName { get; set; } = default!;
        public bool IsActive { get; set; }
    }
}
