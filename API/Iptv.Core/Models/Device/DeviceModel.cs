namespace Iptv.Core.Models
{
    public class DeviceModel : BaseModel
    {
        public string Name { get; set; } = default!;
        public int DeviceTypeId { get; set; }
        public DeviceTypeModel DeviceType { get; set; } = default!;
        public string Manufacturer { get; set; } = default!;
        public string Model { get; set; } = default!;
        public string SerialNumber { get; set; } = default!;
    }
}
