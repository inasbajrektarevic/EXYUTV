using FluentValidation;
using Iptv.Core.Models;

namespace Iptv.Services.Validators
{
    public class ApplicationValidator : AbstractValidator<ApplicationUpsertModel>
    {
        public ApplicationValidator()
        {
            RuleFor(c => c.Name).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
        }
    }
}
