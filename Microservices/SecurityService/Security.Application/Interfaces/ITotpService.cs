namespace Security.Application.Interfaces;

public interface ITotpService
{
    string GenerateSecret();
    string GenerateUri(string secret, string userName, string issuer = "Fceo");
    bool VerifyCode(string secret, string code);
    string GenerateQrPngBase64(string uri, int pixelsPerModule = 8);
}
