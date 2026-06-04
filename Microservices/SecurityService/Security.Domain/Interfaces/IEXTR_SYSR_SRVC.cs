using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_SYSR_SRVC
{
    Task<string> INIT_SYSR_U(string p_in);
    Task<string> LIST_SYSR_U(string p_in);
}
