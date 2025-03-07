using FluentValidation;
using Iptv.Core.Models;

namespace Iptv.Services.Validators
{
    public class ChannelLanguageValidator : AbstractValidator<ChannelLanguageUpsertModel>
    {
        public ChannelLanguageValidator()
        {
            RuleFor(c => c.Name).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.CultureName).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
        }
    }
}
