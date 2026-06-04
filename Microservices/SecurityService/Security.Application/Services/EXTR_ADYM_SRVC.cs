using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_ADYM_SRVC : IEXTR_ADYM_SRVC
    {
        private readonly IEXTR_ADYM_SRVC _repository;

        public EXTR_ADYM_SRVC(IEXTR_ADYM_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_ADYM_U(string p_in)
            => await _repository.INIT_ADYM_U(p_in);

        public async Task<string> CRET_ADYM_U(string p_in)
            => await _repository.CRET_ADYM_U(p_in);

        public async Task<string> REMV_ADYM_U(string p_in)
            => await _repository.REMV_ADYM_U(p_in);

        public async Task<string> UPDT_ADYM_U(string p_in)
            => await _repository.UPDT_ADYM_U(p_in);

        public async Task<string> LIST_ADYM_U(string p_in)
            => await _repository.LIST_ADYM_U(p_in);
    }
}
