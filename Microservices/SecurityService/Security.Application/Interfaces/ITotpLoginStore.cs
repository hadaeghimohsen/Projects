namespace Security.Application.Interfaces;

public sealed class TotpLoginEntry
{
    public string Username { get; init; } = string.Empty;
    public string Secret { get; init; } = string.Empty;
    public string RememberMe { get; init; } = "0";
    public DateTime ExpiresAt { get; init; }
}

public interface ITotpLoginStore
{
    string Create(string username, string secret, string rememberMe);
    TotpLoginEntry? Consume(string token);
    void PurgeExpired();
}
