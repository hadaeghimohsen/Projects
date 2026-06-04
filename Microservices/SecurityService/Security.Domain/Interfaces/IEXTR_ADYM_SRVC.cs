using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_ADYM_SRVC
{
    Task<string> INIT_ADYM_U(string p_in);
    Task<string> CRET_ADYM_U(string p_in);
    Task<string> REMV_ADYM_U(string p_in);
    Task<string> UPDT_ADYM_U(string p_in);
    Task<string> LIST_ADYM_U(string p_in);
}
