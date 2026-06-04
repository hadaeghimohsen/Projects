using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_NEWS_SRVC
{
    Task<string> INIT_NEWS_U(string p_in);
    Task<string> CRET_NEWS_U(string p_in);
    Task<string> REMV_NEWS_U(string p_in);
    Task<string> UPDT_NEWS_U(string p_in);
    Task<string> ACTV_NEWS_U(string p_in);
    Task<string> DACT_NEWS_U(string p_in);
    Task<string> LIST_NEWS_U(string p_in);
}
