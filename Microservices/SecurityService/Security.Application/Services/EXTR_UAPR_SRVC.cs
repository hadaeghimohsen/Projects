using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_UAPR_SRVC : IEXTR_UAPR_SRVC
    {
        private readonly IEXTR_UAPR_SRVC _repository;

        public EXTR_UAPR_SRVC(IEXTR_UAPR_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_UAPR_U(string p_in)
            => await _repository.INIT_UAPR_U(p_in);

        public async Task<string> GRNT_UAPR_U(string p_in)
            => await _repository.GRNT_UAPR_U(p_in);

        public async Task<string> RVOK_UAPR_U(string p_in)
            => await _repository.RVOK_UAPR_U(p_in);

        public async Task<string> CHCK_UAPR_U(string p_in)
            => await _repository.CHCK_UAPR_U(p_in);

        public async Task<string> COPY_UAPR_U(string p_in)
            => await _repository.COPY_UAPR_U(p_in);

        public async Task<string> LIST_UAPR_U(string p_in)
            => await _repository.LIST_UAPR_U(p_in);
    }
}
