using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_UIMG_SRVC : IEXTR_UIMG_SRVC
    {
        private readonly IEXTR_UIMG_SRVC _repository;

        public EXTR_UIMG_SRVC(IEXTR_UIMG_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_UIMG_U(string p_in)
            => await _repository.INIT_UIMG_U(p_in);

        public async Task<string> UPLD_UIMG_U(string p_in)
            => await _repository.UPLD_UIMG_U(p_in);

        public async Task<string> REMV_UIMG_U(string p_in)
            => await _repository.REMV_UIMG_U(p_in);

        public async Task<string> UPDT_UIMG_U(string p_in)
            => await _repository.UPDT_UIMG_U(p_in);

        public async Task<string> ACTV_UIMG_U(string p_in)
            => await _repository.ACTV_UIMG_U(p_in);

        public async Task<string> DACT_UIMG_U(string p_in)
            => await _repository.DACT_UIMG_U(p_in);

        public async Task<string> LIST_UIMG_U(string p_in)
            => await _repository.LIST_UIMG_U(p_in);
    }
}
