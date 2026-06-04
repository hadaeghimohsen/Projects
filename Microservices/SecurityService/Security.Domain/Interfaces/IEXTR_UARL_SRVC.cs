using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_UARL_SRVC
{
    Task<string> INIT_UARL_U(string p_in);
    Task<string> GRNT_UARL_U(string p_in);
    Task<string> RVOK_UARL_U(string p_in);
    Task<string> CHCK_UARL_U(string p_in);
    Task<string> COPY_UARL_U(string p_in);
    Task<string> LIST_UARL_U(string p_in);
}
