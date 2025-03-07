﻿using FluentValidation;
using Iptv.Core.Models;

namespace Iptv.Services.Validators
{
    public class RoleValidator : AbstractValidator<RoleUpsertModel>
    {
        public RoleValidator()
        {
            RuleFor(c => c.Name).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.NormalizedName).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => (int)c.RoleLevel).NotEqual(0).WithErrorCode(ErrorCodes.InvalidValue);
        }
    }
}
