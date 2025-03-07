using Iptv.Core;
using Iptv.Core.Models;

namespace Iptv.Services.Mapping
{
    public class PaymentProfile : BaseProfile
    {
        public PaymentProfile()
        {
            CreateMap<Payment, PaymentModel>().ReverseMap();
            CreateMap<Payment, PaymentUpsertModel>().ReverseMap();
        }
    }
}
