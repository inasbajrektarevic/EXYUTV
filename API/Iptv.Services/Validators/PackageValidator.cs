using FluentValidation;
using Iptv.Core.Models;

namespace Iptv.Services.Validators
{
    public class PackageValidator : AbstractValidator<PackageUpsertModel>
    {
        public PackageValidator()
        {
            RuleFor(c => c.Name).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => (int)c.Status).NotEqual(0).WithErrorCode(ErrorCodes.InvalidValue);
            RuleFor(c => c.Price).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.CreatedById).NotEqual(0).WithErrorCode(ErrorCodes.InvalidValue);
            RuleFor(c => c.CountryId).NotEqual(0).WithErrorCode(ErrorCodes.InvalidValue);
        }
    }
}
