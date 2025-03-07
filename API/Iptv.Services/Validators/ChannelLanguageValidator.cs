using FluentValidation;
using Iptv.Core.Models;

namespace Iptv.Services.Validators
{
    public class ChannelCategoryValidator : AbstractValidator<ChannelCategoryUpsertModel>
    {
        public ChannelCategoryValidator()
        {
            RuleFor(c => c.Name).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.OrderNumber).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
        }
    }
}
