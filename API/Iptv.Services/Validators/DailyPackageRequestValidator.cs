using FluentValidation;
using Iptv.Core.Models;

namespace Iptv.Services.Validators
{
    public class DailyPackageRequestValidator : AbstractValidator<DailyPackageRequestUpsertModel>
    {
        public DailyPackageRequestValidator()
        {
            RuleFor(c => c.FirstName).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.LastName).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.Email).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.PhoneNumber).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.DeviceId).NotEqual(0).WithErrorCode(ErrorCodes.InvalidValue);
            RuleFor(c => c.ApplicationId).NotEqual(0).WithErrorCode(ErrorCodes.InvalidValue);
        }
    }
}
