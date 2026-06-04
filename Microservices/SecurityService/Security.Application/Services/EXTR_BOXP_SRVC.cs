using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_BOXP_SRVC : IEXTR_BOXP_SRVC
    {
        private readonly IEXTR_BOXP_SRVC _repository;

        public EXTR_BOXP_SRVC(IEXTR_BOXP_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_BOXP_U(string p_in)
            => await _repository.INIT_BOXP_U(p_in);

        public async Task<string> CRET_BOXP_U(string p_in)
            => await _repository.CRET_BOXP_U(p_in);

        public async Task<string> REMV_BOXP_U(string p_in)
            => await _repository.REMV_BOXP_U(p_in);

        public async Task<string> UPDT_BOXP_U(string p_in)
            => await _repository.UPDT_BOXP_U(p_in);

        public async Task<string> LIST_BOXP_U(string p_in)
            => await _repository.LIST_BOXP_U(p_in);
    }
}
