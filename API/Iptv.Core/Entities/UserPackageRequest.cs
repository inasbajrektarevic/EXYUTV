namespace Iptv.Core
{
    public class UserPackageRequest : BaseEntity
    {
        public UserPackageRequestStatus Status { get; set; }
        public int PackageId { get; set; }
        public Package Package { get; set; } = default!;
        public int UserId { get; set; }
        public User User { get; set; } = default!;
    }
}
