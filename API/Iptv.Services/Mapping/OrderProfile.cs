using Iptv.Core;
using Iptv.Core.Models;

namespace Iptv.Services.Mapping
{
    public class OrderProfile : BaseProfile
    {
        public OrderProfile()
        {
            CreateMap<Order, OrderModel>().ReverseMap();
            CreateMap<Order, OrderUpsertModel>().ReverseMap();
        }
    }
}
