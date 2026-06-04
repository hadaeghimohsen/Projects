using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_PGAT_SRVC
{
    Task<string> INIT_PGAT_U(string p_in);
    Task<string> LIST_PGAT_U(string p_in);
}
