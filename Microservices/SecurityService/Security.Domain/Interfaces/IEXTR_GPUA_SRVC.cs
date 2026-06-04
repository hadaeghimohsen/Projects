using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_GPUA_SRVC
{
    Task<string> INIT_GPUA_U(string p_in);
    Task<string> JOIN_GPUA_U(string p_in);
    Task<string> LEFT_GPUA_U(string p_in);
    Task<string> ACTV_GPUA_U(string p_in);
    Task<string> DACV_GPUA_U(string p_in);
    Task<string> LIST_GPUA_U(string p_in);
}
