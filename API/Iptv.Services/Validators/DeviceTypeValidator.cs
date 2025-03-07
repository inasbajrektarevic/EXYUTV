using FluentValidation;
using Iptv.Core.Models;

namespace Iptv.Services.Validators
{
    public class DeviceTypeValidator : AbstractValidator<DeviceTypeUpsertModel>
    {
        public DeviceTypeValidator()
        {
            RuleFor(c => c.Name).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
        }
    }
}
