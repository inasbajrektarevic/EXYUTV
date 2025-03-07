namespace Iptv.Core
{
    public class Package : BaseEntity
    {
        public string Name { get; set; } = default!;
        public PackageStatus Status { get; set; }
        public bool IsPromotional { get; set; }
        public bool RequiresSubscription { get; set; }
        public decimal Price { get; set; }
        public decimal? Discount { get; set; }
        public string? IconUrl { get; set; }
        public string Description { get; set; } = default!;
        public int CreatedById { get; set; }
        public User CreatedBy { get; set; } = default!;
        public int CountryId { get; set; }
        public Country Country { get; set; } = default!;
        public ICollection<DevicePackage> AvailableDevices { get; set; } = [];
        public ICollection<PackageChannelCategory> ChannelCategories { get; set; } = [];

    }
}
