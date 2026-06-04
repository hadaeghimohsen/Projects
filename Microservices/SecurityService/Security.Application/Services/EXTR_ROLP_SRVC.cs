using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_ROLP_SRVC : IEXTR_ROLP_SRVC
    {
        private readonly IEXTR_ROLP_SRVC _repository;

        public EXTR_ROLP_SRVC(IEXTR_ROLP_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_ROLP_U(string p_in)
            => await _repository.INIT_ROLP_U(p_in);

        public async Task<string> GRNT_ROLP_U(string p_in)
            => await _repository.GRNT_ROLP_U(p_in);

        public async Task<string> RVOK_ROLP_U(string p_in)
            => await _repository.RVOK_ROLP_U(p_in);

        public async Task<string> CHCK_ROLP_U(string p_in)
            => await _repository.CHCK_ROLP_U(p_in);

        public async Task<string> COPY_ROLP_U(string p_in)
            => await _repository.COPY_ROLP_U(p_in);

        public async Task<string> LIST_ROLP_U(string p_in)
            => await _repository.LIST_ROLP_U(p_in);
    }
}
