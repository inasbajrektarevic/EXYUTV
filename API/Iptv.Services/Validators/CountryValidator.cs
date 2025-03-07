using FluentValidation;
using Iptv.Core.Models;

namespace Iptv.Services.Validators
{
    public class CountryValidator : AbstractValidator<CountryUpsertModel>
    {
        public CountryValidator()
        {
            RuleFor(c => c.Name).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.Abrv).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.IsActive).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
