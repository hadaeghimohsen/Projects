using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_UIMG_SRVC
{
    Task<string> INIT_UIMG_U(string p_in);
    Task<string> UPLD_UIMG_U(string p_in);
    Task<string> REMV_UIMG_U(string p_in);
    Task<string> UPDT_UIMG_U(string p_in);
    Task<string> ACTV_UIMG_U(string p_in);
    Task<string> DACT_UIMG_U(string p_in);
    Task<string> LIST_UIMG_U(string p_in);
}
