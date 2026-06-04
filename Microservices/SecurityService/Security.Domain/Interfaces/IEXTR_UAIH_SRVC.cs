using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_UAIH_SRVC
{
    Task<string> INIT_UAIH_U(string p_in);
    Task<string> LIST_UAIH_U(string p_in);
}
