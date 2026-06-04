using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_ROLE_SRVC
{
    Task<string> INIT_ROLE_U(string p_in);
    Task<string> CRET_ROLE_U(string p_in);
    Task<string> REMV_ROLE_U(string p_in);
    Task<string> UPDT_ROLE_U(string p_in);
    Task<string> ACTV_ROLE_U(string p_in);
    Task<string> DACT_ROLE_U(string p_in);
    Task<string> DUPL_ROLE_U(string p_in);
    Task<string> LIST_ROLE_U(string p_in);
}
