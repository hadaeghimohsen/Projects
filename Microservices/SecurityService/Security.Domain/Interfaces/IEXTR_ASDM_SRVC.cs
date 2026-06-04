using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_ASDM_SRVC
{
    Task<string> INIT_ASDM_U(string p_in);
    Task<string> CRET_ASDM_U(string p_in);
    Task<string> REMV_ASDM_U(string p_in);
    Task<string> UPDT_ASDM_U(string p_in);
    Task<string> LIST_ASDM_U(string p_in);
}
