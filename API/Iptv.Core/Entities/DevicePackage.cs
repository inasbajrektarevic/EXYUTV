namespace Iptv.Core
{
    public class DevicePackage:BaseEntity
    {
        public int DeviceId { get; set; }
        public Device Device { get; set; } = default!;
        public int PackageId { get; set; }
        public Package Package { get; set; } = default!;
        public string Instructions { get; set; } = default!;
        public string Note { get; set; } = default!;
    }
}
