namespace Iptv.Core
{
    public class DailyPackageRequest : BaseEntity
    {
        public string FirstName { get; set; } = default!;
        public string LastName { get; set; } = default!;
        public string Email { get; set; } = default!;
        public string PhoneNumber { get; set; } = default!;
        public DateTime DateTimeFrom { get; set; }
        public DateTime DateTimeTo { get; set; }
        public UserPackageRequestStatus Status { get; set; }
        public int DeviceId { get; set; }
        public Device Device { get; set; } = default!;
        public int ApplicationId { get; set; }
        public Application Application { get; set; } = default!;
    }
}
