using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_BRDC_SRVC : IEXTR_BRDC_SRVC
    {
        private readonly IEXTR_BRDC_SRVC _repository;

        public EXTR_BRDC_SRVC(IEXTR_BRDC_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_BRDC_U(string p_in)
            => await _repository.INIT_BRDC_U(p_in);

        public async Task<string> CRET_BRDC_U(string p_in)
            => await _repository.CRET_BRDC_U(p_in);

        public async Task<string> REMV_BRDC_U(string p_in)
            => await _repository.REMV_BRDC_U(p_in);

        public async Task<string> UPDT_BRDC_U(string p_in)
            => await _repository.UPDT_BRDC_U(p_in);

        public async Task<string> LIST_BRDC_U(string p_in)
            => await _repository.LIST_BRDC_U(p_in);
    }
}
