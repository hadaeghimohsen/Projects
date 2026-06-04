namespace Security.Application.Dtos;

public class LoginResponseDto
{
    public string Token { get; set; } = string.Empty;
    public string Username { get; set; } = string.Empty;
    public DateTime ExpiresAt { get; set; }

    public bool Success { get; set; } = false;
    public string Rspncode { get; set; } = string.Empty;
    public string Rspndesc { get; set; } = string.Empty;
    public string OracleErrorMessage { get; set; } = string.Empty;
    public int Elpstime { get; set; }
}