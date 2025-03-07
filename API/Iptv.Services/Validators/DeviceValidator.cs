using FluentValidation;
using Iptv.Core.Models;

namespace Iptv.Services.Validators
{
    public class DeviceValidator : AbstractValidator<DeviceUpsertModel>
    {
        public DeviceValidator()
        {
            RuleFor(c => c.Name).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.Manufacturer).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.SerialNumber).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.DeviceTypeId).NotEqual(0).WithErrorCode(ErrorCodes.InvalidValue);
        }
    }
}
