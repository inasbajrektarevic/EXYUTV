namespace Iptv.Core
{
    public class UserChannel : BaseEntity
    {
        public int UserId { get; set; }
        public User User { get; set; } = default!;
        public bool IsLike { get; set; }
        public bool IsFavorite { get; set; }
        public float Rating { get; set; }
        public string Comment { get; set; } = default!;
    }
}
