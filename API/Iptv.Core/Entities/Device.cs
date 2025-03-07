namespace Iptv.Core
{
    public class Device:BaseEntity
    {
        public string Name { get; set; } = default!;
        public int DeviceTypeId { get; set; }
        public DeviceType DeviceType { get; set; } = default!;
        public string Manufacturer { get; set; } = default!;
        public string Model { get; set; } = default!;
        public string SerialNumber { get; set; } = default!;
    }
}
