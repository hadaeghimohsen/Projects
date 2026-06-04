using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_DSRC_SRVC : IEXTR_DSRC_SRVC
    {
        private readonly IEXTR_DSRC_SRVC _repository;

        public EXTR_DSRC_SRVC(IEXTR_DSRC_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_DSRC_U(string p_in)
            => await _repository.INIT_DSRC_U(p_in);

        public async Task<string> CRET_DSRC_U(string p_in)
            => await _repository.CRET_DSRC_U(p_in);

        public async Task<string> REMV_DSRC_U(string p_in)
            => await _repository.REMV_DSRC_U(p_in);

        public async Task<string> UPDT_DSRC_U(string p_in)
            => await _repository.UPDT_DSRC_U(p_in);

        public async Task<string> LIST_DSRC_U(string p_in)
            => await _repository.LIST_DSRC_U(p_in);
    }
}
