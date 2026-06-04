using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_PTRN_SRVC
{
    Task<string> INIT_PTRN_U(string p_in);
    Task<string> LIST_PTRN_U(string p_in);
}
