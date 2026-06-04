using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_NEWS_SRVC : IEXTR_NEWS_SRVC
    {
        private readonly IEXTR_NEWS_SRVC _repository;

        public EXTR_NEWS_SRVC(IEXTR_NEWS_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_NEWS_U(string p_in)
            => await _repository.INIT_NEWS_U(p_in);

        public async Task<string> CRET_NEWS_U(string p_in)
            => await _repository.CRET_NEWS_U(p_in);

        public async Task<string> REMV_NEWS_U(string p_in)
            => await _repository.REMV_NEWS_U(p_in);

        public async Task<string> UPDT_NEWS_U(string p_in)
            => await _repository.UPDT_NEWS_U(p_in);

        public async Task<string> ACTV_NEWS_U(string p_in)
            => await _repository.ACTV_NEWS_U(p_in);

        public async Task<string> DACT_NEWS_U(string p_in)
            => await _repository.DACT_NEWS_U(p_in);

        public async Task<string> LIST_NEWS_U(string p_in)
            => await _repository.LIST_NEWS_U(p_in);
    }
}
