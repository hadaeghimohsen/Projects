using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_PRVL_SRVC : IEXTR_PRVL_SRVC
    {
        private readonly IEXTR_PRVL_SRVC _repository;

        public EXTR_PRVL_SRVC(IEXTR_PRVL_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_PRVL_U(string p_in)
            => await _repository.INIT_PRVL_U(p_in);

        public async Task<string> CRET_PRVL_U(string p_in)
            => await _repository.CRET_PRVL_U(p_in);

        public async Task<string> REMV_PRVL_U(string p_in)
            => await _repository.REMV_PRVL_U(p_in);

        public async Task<string> UPDT_PRVL_U(string p_in)
            => await _repository.UPDT_PRVL_U(p_in);

        public async Task<string> ACTV_PRVL_U(string p_in)
            => await _repository.ACTV_PRVL_U(p_in);

        public async Task<string> DACT_PRVL_U(string p_in)
            => await _repository.DACT_PRVL_U(p_in);

        public async Task<string> LIST_PRVL_U(string p_in)
            => await _repository.LIST_PRVL_U(p_in);
    }
}
