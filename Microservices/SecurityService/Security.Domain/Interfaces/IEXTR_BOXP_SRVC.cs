using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_BOXP_SRVC
{
    Task<string> INIT_BOXP_U(string p_in);
    Task<string> CRET_BOXP_U(string p_in);
    Task<string> REMV_BOXP_U(string p_in);
    Task<string> UPDT_BOXP_U(string p_in);
    Task<string> LIST_BOXP_U(string p_in);
}
