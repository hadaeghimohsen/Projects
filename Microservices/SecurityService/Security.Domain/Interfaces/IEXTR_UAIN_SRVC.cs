using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_UAIN_SRVC
{
    Task<string> INIT_UAIN_U(string p_in);
    Task<string> LIST_UAIN_U(string p_in);
    Task<string> COPY_UAIN_U(string p_in);
}
