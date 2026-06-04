using Security.Domain.Model;

namespace Security.Domain.Interfaces;

public interface IEXTR_DSRC_SRVC
{
    Task<string> INIT_DSRC_U(string p_in);
    Task<string> CRET_DSRC_U(string p_in);
    Task<string> REMV_DSRC_U(string p_in);
    Task<string> UPDT_DSRC_U(string p_in);
    Task<string> LIST_DSRC_U(string p_in);
}
