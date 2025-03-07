using FluentValidation;
using Iptv.Core.Models;

namespace Iptv.Services.Validators
{
    public class OrderValidator : AbstractValidator<OrderUpsertModel>
    {
        public OrderValidator()
        {
            RuleFor(c => c.Name).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => (int)c.Type).NotEqual(0).WithErrorCode(ErrorCodes.InvalidValue);
            RuleFor(c => c.Price).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.PackageId).NotEqual(0).WithErrorCode(ErrorCodes.InvalidValue);
            RuleFor(c => c.UserId).NotEqual(0).WithErrorCode(ErrorCodes.InvalidValue);
        }
    }
}
