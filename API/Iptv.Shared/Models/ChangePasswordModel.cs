﻿namespace Iptv.Shared
{
    public class ChangePasswordModel
    {
        public string CurrentPassword { get; set; } = default!;
        public string NewPassword { get; set; } = default!;
    }
}
