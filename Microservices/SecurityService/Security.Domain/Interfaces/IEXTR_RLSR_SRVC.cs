using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_RLSR_SRVC
{
    Task<string> INIT_RLSR_U(string p_in);
    Task<string> LIST_RLSR_U(string p_in);
}
