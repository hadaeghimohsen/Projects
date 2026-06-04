using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_UNOT_SRVC
{
    Task<string> INIT_UNOT_U(string p_in);
    Task<string> INBX_UNOT_U(string p_in);
    Task<string> READ_UNOT_U(string p_in);
    Task<string> PINT_UNOT_U(string p_in);
    Task<string> UPIN_UNOT_U(string p_in);
    Task<string> LIST_UNOT_U(string p_in);
}
