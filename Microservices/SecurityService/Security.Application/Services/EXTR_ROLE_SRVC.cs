using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_ROLE_SRVC : IEXTR_ROLE_SRVC
    {
        private readonly IEXTR_ROLE_SRVC _repository;

        public EXTR_ROLE_SRVC(IEXTR_ROLE_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_ROLE_U(string p_in)
            => await _repository.INIT_ROLE_U(p_in);

        public async Task<string> CRET_ROLE_U(string p_in)
            => await _repository.CRET_ROLE_U(p_in);

        public async Task<string> REMV_ROLE_U(string p_in)
            => await _repository.REMV_ROLE_U(p_in);

        public async Task<string> UPDT_ROLE_U(string p_in)
            => await _repository.UPDT_ROLE_U(p_in);

        public async Task<string> ACTV_ROLE_U(string p_in)
            => await _repository.ACTV_ROLE_U(p_in);

        public async Task<string> DACT_ROLE_U(string p_in)
            => await _repository.DACT_ROLE_U(p_in);

        public async Task<string> DUPL_ROLE_U(string p_in)
            => await _repository.DUPL_ROLE_U(p_in);

        public async Task<string> LIST_ROLE_U(string p_in)
            => await _repository.LIST_ROLE_U(p_in);
    }
}
