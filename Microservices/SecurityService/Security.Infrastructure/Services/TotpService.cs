using OtpNet;
using QRCoder;
using Security.Application.Interfaces;

namespace Security.Infrastructure.Services;

public class TotpService : ITotpService
{
    public const int SecretLength = 20;

    public string GenerateSecret()
    {
        var key = KeyGeneration.GenerateRandomKey(SecretLength);
        return Base32Encoding.ToString(key);
    }

    public string GenerateUri(string secret, string userName, string issuer = "Fceo")
    {
        return new OtpUri(OtpType.Totp, secret, userName, issuer).ToString();
    }

    public bool VerifyCode(string secret, string code)
    {
        if (string.IsNullOrEmpty(secret) || string.IsNullOrEmpty(code))
            return false;

        var keyBytes = Base32Encoding.ToBytes(secret);
        var totp = new Totp(keyBytes);
        // افزایش پنجره به 5 قدم (150 ثانیه قبل/بعد) برای تساهل در نوسان ساعت
        return totp.VerifyTotp(code, out _, new VerificationWindow(5, 5));
    }

    public string GenerateQrPngBase64(string uri, int pixelsPerModule = 8)
    {
        using var qrGenerator = new QRCodeGenerator();
        using var qrData = qrGenerator.CreateQrCode(uri, QRCoder.QRCodeGenerator.ECCLevel.M);
        using var qrCode = new PngByteQRCode(qrData);
        var bytes = qrCode.GetGraphic(pixelsPerModule);
        return Convert.ToBase64String(bytes);
    }
}
