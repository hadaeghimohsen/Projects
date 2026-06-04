using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_HINF_SRVC
{
    Task<string> INIT_HINF_U(string p_in);
    Task<string> REGS_HINF_U(string p_in);
    Task<string> LIST_HINF_U(string p_in);
}
