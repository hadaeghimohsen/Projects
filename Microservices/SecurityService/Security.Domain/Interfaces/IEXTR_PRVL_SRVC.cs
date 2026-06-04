using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_PRVL_SRVC
{
    Task<string> INIT_PRVL_U(string p_in);
    Task<string> CRET_PRVL_U(string p_in);
    Task<string> REMV_PRVL_U(string p_in);
    Task<string> UPDT_PRVL_U(string p_in);
    Task<string> ACTV_PRVL_U(string p_in);
    Task<string> DACT_PRVL_U(string p_in);
    Task<string> LIST_PRVL_U(string p_in);
}
