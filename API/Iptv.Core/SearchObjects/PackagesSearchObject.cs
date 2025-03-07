namespace Iptv.Core.SearchObjects
{
    public class PackagesSearchObject : BaseSearchObject
    {
        public int? Status { get; set; }
        public int? CountryId { get; set; }
        public int? CreatedById { get; set; }
    }
}
