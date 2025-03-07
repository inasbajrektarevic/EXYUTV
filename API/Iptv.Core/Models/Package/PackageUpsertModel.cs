using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;

namespace Iptv.Core.Models
{
    public class PackageUpsertModel : BaseUpsertModel
    {
        public string Name { get; set; } = default!;
        public PackageStatus Status { get; set; }
        public bool IsPromotional { get; set; }
        public bool RequiresSubscription { get; set; }
        public decimal Price { get; set; }
        public decimal? Discount { get; set; }
        public string? IconUrl { get; set; } = default!;
        public IFormFile? Icon { get; set; }
        public string Description { get; set; } = default!;
        public int CreatedById { get; set; }
        public int CountryId { get; set; }
        public string ChannelCategorieIds { get; set; } = default!;
    }
}
