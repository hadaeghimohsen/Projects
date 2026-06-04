using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_CSTR_SRVC
{
    Task<string> INIT_CSTR_U(string p_in);
    Task<string> CRET_CSTR_U(string p_in);
    Task<string> REMV_CSTR_U(string p_in);
    Task<string> ACTV_CSTR_U(string p_in);
    Task<string> DACT_CSTR_U(string p_in);
    Task<string> GET_CSTR_U(string p_in);
    Task<string> LIST_CSTR_U(string p_in);
}
