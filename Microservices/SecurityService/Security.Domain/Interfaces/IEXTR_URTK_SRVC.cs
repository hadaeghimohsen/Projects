using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_URTK_SRVC
{
    Task<string> INIT_URTK_U(string p_in);
    Task<string> LIST_URTK_U(string p_in);
}
