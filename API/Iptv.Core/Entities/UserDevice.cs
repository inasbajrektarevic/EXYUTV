namespace Iptv.Core
{
    public class UserDevice : BaseEntity
    {
        public int DeviceId { get; set; }
        public Device Device { get; set; } = default!;
        public int UserId { get; set; }
        public User User { get; set; } = default!;
    }
}
