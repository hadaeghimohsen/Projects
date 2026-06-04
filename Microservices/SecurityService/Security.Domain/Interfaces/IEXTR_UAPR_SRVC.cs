using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_UAPR_SRVC
{
    Task<string> INIT_UAPR_U(string p_in);
    Task<string> GRNT_UAPR_U(string p_in);
    Task<string> RVOK_UAPR_U(string p_in);
    Task<string> CHCK_UAPR_U(string p_in);
    Task<string> COPY_UAPR_U(string p_in);
    Task<string> LIST_UAPR_U(string p_in);
}
