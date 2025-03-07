using Iptv.Shared;

namespace Iptv.Api
{
    public interface IAccessManager
    {
        Task<LoginInformationModel> SignInAsync(string email, string password, bool rememberMe = false);
        Task<bool> ChangePassword(int userId, string currentPassword, string newPassword);
        Task<bool> ResetPassword(string email, string? newPassword = null);
    }
}
