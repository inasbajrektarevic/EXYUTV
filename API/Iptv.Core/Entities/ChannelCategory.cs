using System.Text.Json.Serialization;

namespace Iptv.Core
{
    public class ChannelCategory : BaseEntity
    {
        public string Name { get; set; } = default!;
        public bool IsActive { get; set; }
        public string Description { get; set; } = default!;
        public int OrderNumber { get; set; }
        public ICollection<Channel> Channels { get; set; } = [];
    }
}
