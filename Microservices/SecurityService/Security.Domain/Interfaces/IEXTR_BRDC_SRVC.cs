using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_BRDC_SRVC
{
    Task<string> INIT_BRDC_U(string p_in);
    Task<string> CRET_BRDC_U(string p_in);
    Task<string> REMV_BRDC_U(string p_in);
    Task<string> UPDT_BRDC_U(string p_in);
    Task<string> LIST_BRDC_U(string p_in);
}
