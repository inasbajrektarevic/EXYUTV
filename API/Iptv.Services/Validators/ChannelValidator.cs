using FluentValidation;
using Iptv.Core.Models;

namespace Iptv.Services.Validators
{
    public class ChannelValidator : AbstractValidator<ChannelUpsertModel>
    {
        public ChannelValidator()
        {
            RuleFor(c => c.Name).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.Frequency).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.StreamUrl).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.ChannelNumber).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.Owner).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.CountryId).NotEqual(0).WithErrorCode(ErrorCodes.InvalidValue);
            RuleFor(c => c.ChannelCategoryId).NotEqual(0).WithErrorCode(ErrorCodes.InvalidValue);
            RuleFor(c => c.ChannelLanguageId).NotEqual(0).WithErrorCode(ErrorCodes.InvalidValue);
        }
    }
}
