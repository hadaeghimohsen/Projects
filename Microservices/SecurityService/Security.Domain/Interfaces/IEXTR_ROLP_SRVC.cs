using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_ROLP_SRVC
{
    Task<string> INIT_ROLP_U(string p_in);
    Task<string> GRNT_ROLP_U(string p_in);
    Task<string> RVOK_ROLP_U(string p_in);
    Task<string> CHCK_ROLP_U(string p_in);
    Task<string> COPY_ROLP_U(string p_in);
    Task<string> LIST_ROLP_U(string p_in);
}
