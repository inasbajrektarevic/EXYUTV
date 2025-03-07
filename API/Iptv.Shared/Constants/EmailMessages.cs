namespace Iptv.Shared
{
    public class EmailMessages
    {
        public const string ResetPasswordSubject = "Ex-yu TV Team | Resetovanje lozinke";
        public const string ConfirmationEmailSubject = "Ex-yu TV Team | Dodjela korisničkog naloga";
        public const string ClientEmailSubject = "Ex-yu TV Team | Dodjela uloge klijenta";
        public const string DailyRequestSubject = "Ex-yu TV Team | Dnevni zahtjev";
        public static string GeneratePasswordEmail(string name, string password, string token, string clientUrl)
        {
            string body =
                $"<p style='text-align:center;color:black'>Poštovani {name},</p>" +
                $"</br>" +
                $"<div style='text-align:center;'>" +
                $"<span style='text-align:center;color:black'>Uspješno je kreiran račun na aplikaciji</span> " +
                $"<span style='font-weight:bold;display:inline;color:black;'>Ex-yu TV</span>." +
                $"</div>" +
                $"</br>" +
                $"<div style='text-align:center;'>" +
                $"<span style='text-align:center;color:black'>Vaš privremeni password je:</span>" +
                $"<span style='font-weight:bold;display:inline'> {password}</span>" +
                $"</div>" +
                $"</br>" +
                $"</br>" +
                $"<a style='display:block; width:40%; margin:auto; cursor:pointer;' href='{clientUrl}/verify-email/token={token}'> " +
                $"<button style='background-color:#0067b8;color:white;width:100%;height:30px;text-align:center;border-radius:5px; cursor:pointer;'>" +
                $"Verifikacija" +
                $"</button>" +
                $"</a>" +
                $"<p style='text-align:center; color:black'>Uživajte u korištenju aplikacije.</p>";

            return EmailWrapper.WrapBody(body);
        }

        public static string GenerateResetPasswordEmail(string name, string password, string clientUrl)
        {
            string body =
                $"<p style='text-align:center;color:black'>Poštovani {name},</p>" +
                $"</br>" +
                $"<div style='text-align:center;'>" +
                $"<span style='text-align:center;color:black'>Uspješno ste resetovali šifru na aplikaciji</span> " +
                $"<span style='font-weight:bold;display:inline;'>Ex-yu TV</span>." +
                $"</div>" +
                $"</br>" +
                $"<div style='text-align:center;'>" +
                $"<span style='text-align:center;color:black'>Vaša nova šifra je:</span>" +
                $"<span style='font-weight:bold;display:inline'> {password}</span>" +
                $"</div>" +
                $"</br>" +
                $"</br>" +
                $"<a style='display:block; width:40%; margin:auto; cursor:pointer;' href='{clientUrl}/login'> " +
                $"<button style='background-color:#0067b8;color:white;width:100%;height:30px;text-align:center;border-radius:5px; cursor:pointer;'>" +
                $"Prijava" +
                $"</button>" +
                $"</a>" +
                $"<p style='text-align:center; color:black'>Uživajte u korištenju aplikacije.</p>";

            return EmailWrapper.WrapBody(body);
        }

        public static string GenerateDailyRequestEmail(string name, string period, string activationCode)
        {
            string body =
                $"<p style='text-align:center;color:black'>Poštovani {name},</p>" +
                $"</br>" +
                $"<div style='text-align:center;'>" +
                $"<span style='text-align:center;color:black'>Odobren je dnevni zahtjev na aplikaciji u periodu {period}</span> " +
                $"<span style='font-weight:bold;display:inline;color:black;'>Ex-yu TV</span>." +
                $"</div>" +
                $"</br>" +
                $"<div style='text-align:center;'>" +
                $"<span style='text-align:center;color:black'>Vaš aktivacijski kod je:</span>" +
                $"<span style='font-weight:bold;display:inline'> {activationCode}</span>" +
                $"</div>" +
                $"</br>" +
                $"</br>" +
                $"<p style='text-align:center; color:black'>Uživajte u gledanju.</p>";

            return EmailWrapper.WrapBody(body);
        }
    }
}
