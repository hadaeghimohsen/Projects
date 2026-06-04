using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_UARL_SRVC : IEXTR_UARL_SRVC
    {
        private readonly IEXTR_UARL_SRVC _repository;

        public EXTR_UARL_SRVC(IEXTR_UARL_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_UARL_U(string p_in)
            => await _repository.INIT_UARL_U(p_in);

        public async Task<string> GRNT_UARL_U(string p_in)
            => await _repository.GRNT_UARL_U(p_in);

        public async Task<string> RVOK_UARL_U(string p_in)
            => await _repository.RVOK_UARL_U(p_in);

        public async Task<string> CHCK_UARL_U(string p_in)
            => await _repository.CHCK_UARL_U(p_in);

        public async Task<string> COPY_UARL_U(string p_in)
            => await _repository.COPY_UARL_U(p_in);

        public async Task<string> LIST_UARL_U(string p_in)
            => await _repository.LIST_UARL_U(p_in);
    }
}
