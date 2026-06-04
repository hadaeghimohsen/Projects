using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_SYS_SRVC
{
    Task<string> INIT_SYS_U(string p_in);
    Task<string> CRET_SYS_U(string p_in);
    Task<string> REMV_SYS_U(string p_in);
    Task<string> UPDT_SYS_U(string p_in);
    Task<string> LIST_SYS_U(string p_in);
}
