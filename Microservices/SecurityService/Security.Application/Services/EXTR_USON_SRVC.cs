using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_USON_SRVC : IEXTR_USON_SRVC
    {
        private readonly IEXTR_USON_SRVC _repository;

        public EXTR_USON_SRVC(IEXTR_USON_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_USON_U(string p_in)
            => await _repository.INIT_USON_U(p_in);

        public async Task<string> CRET_USON_U(string p_in)
            => await _repository.CRET_USON_U(p_in);

        public async Task<string> LOUT_USON_U(string p_in)
            => await _repository.LOUT_USON_U(p_in);

        public async Task<string> LSEN_USON_U(string p_in)
            => await _repository.LSEN_USON_U(p_in);

        public async Task<string> ACTV_USON_U(string p_in)
            => await _repository.ACTV_USON_U(p_in);

        public async Task<string> DACT_USON_U(string p_in)
            => await _repository.DACT_USON_U(p_in);

        public async Task<string> LIST_USON_U(string p_in)
            => await _repository.LIST_USON_U(p_in);
    }
}
