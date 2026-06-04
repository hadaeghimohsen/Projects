using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_MSGB_SRVC
{
    Task<string> INIT_MSGB_U(string p_in);
    Task<string> CRET_MSGB_U(string p_in);
    Task<string> REMV_MSGB_U(string p_in);
    Task<string> UPDT_MSGB_U(string p_in);
    Task<string> ACTV_MSGB_U(string p_in);
    Task<string> DACT_MSGB_U(string p_in);
    Task<string> CSDT_MSGB_U(string p_in);
    Task<string> CTRG_MSGB_U(string p_in);
    Task<string> VIST_MSGB_U(string p_in);
    Task<string> LIST_MSGB_U(string p_in);
}
