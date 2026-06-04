using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_SRRH_SRVC
{
    Task<string> INIT_SRRH_U(string p_in);
    Task<string> LIST_SRRH_U(string p_in);
}
