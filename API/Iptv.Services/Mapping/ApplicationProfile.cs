using Iptv.Core;
using Iptv.Core.Models;

namespace Iptv.Services.Mapping
{
    public class ActivityLogProfile : BaseProfile
    {
        public ActivityLogProfile()
        {
            CreateMap<ActivityLog, ActivityLogModel>().ReverseMap();
            CreateMap<ActivityLog, ActivityLogUpsertModel>().ReverseMap();
        }
    }
}
