namespace Iptv.Core.Models
{
    public class DeviceUpsertModel : BaseUpsertModel
    {
        public string Name { get; set; } = default!;
        public int DeviceTypeId { get; set; }
        public string Manufacturer { get; set; } = default!;
        public string Model { get; set; } = default!;
        public string SerialNumber { get; set; } = default!;
    }
}
