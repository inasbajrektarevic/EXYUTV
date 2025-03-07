using FluentValidation;
using Iptv.Core.Models;

namespace Iptv.Services.Validators
{
    public class ActivityLogValidator : AbstractValidator<ActivityLogUpsertModel>
    {
        public ActivityLogValidator()
        {
        }
    }
}
