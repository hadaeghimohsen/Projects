using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_GROP_SRVC
{
    Task<string> INIT_GROP_U(string p_in);
    Task<string> CRET_GROP_U(string p_in);
    Task<string> REMV_GROP_U(string p_in);
    Task<string> UPDT_GROP_U(string p_in);
    Task<string> LIST_GROP_U(string p_in);
}
