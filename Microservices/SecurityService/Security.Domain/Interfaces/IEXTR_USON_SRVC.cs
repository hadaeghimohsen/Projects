using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_USON_SRVC
{
    Task<string> INIT_USON_U(string p_in);
    Task<string> CRET_USON_U(string p_in);
    Task<string> LOUT_USON_U(string p_in);
    Task<string> LSEN_USON_U(string p_in);
    Task<string> ACTV_USON_U(string p_in);
    Task<string> DACT_USON_U(string p_in);
    Task<string> LIST_USON_U(string p_in);
}
