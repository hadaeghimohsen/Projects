using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_ASDM_SRVC : IEXTR_ASDM_SRVC
    {
        private readonly IEXTR_ASDM_SRVC _repository;

        public EXTR_ASDM_SRVC(IEXTR_ASDM_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_ASDM_U(string p_in)
            => await _repository.INIT_ASDM_U(p_in);

        public async Task<string> CRET_ASDM_U(string p_in)
            => await _repository.CRET_ASDM_U(p_in);

        public async Task<string> REMV_ASDM_U(string p_in)
            => await _repository.REMV_ASDM_U(p_in);

        public async Task<string> UPDT_ASDM_U(string p_in)
            => await _repository.UPDT_ASDM_U(p_in);

        public async Task<string> LIST_ASDM_U(string p_in)
            => await _repository.LIST_ASDM_U(p_in);
    }
}
