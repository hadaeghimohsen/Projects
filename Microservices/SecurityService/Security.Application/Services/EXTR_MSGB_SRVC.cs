using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_MSGB_SRVC : IEXTR_MSGB_SRVC
    {
        private readonly IEXTR_MSGB_SRVC _repository;

        public EXTR_MSGB_SRVC(IEXTR_MSGB_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_MSGB_U(string p_in)
            => await _repository.INIT_MSGB_U(p_in);

        public async Task<string> CRET_MSGB_U(string p_in)
            => await _repository.CRET_MSGB_U(p_in);

        public async Task<string> REMV_MSGB_U(string p_in)
            => await _repository.REMV_MSGB_U(p_in);

        public async Task<string> UPDT_MSGB_U(string p_in)
            => await _repository.UPDT_MSGB_U(p_in);

        public async Task<string> ACTV_MSGB_U(string p_in)
            => await _repository.ACTV_MSGB_U(p_in);

        public async Task<string> DACT_MSGB_U(string p_in)
            => await _repository.DACT_MSGB_U(p_in);

        public async Task<string> CSDT_MSGB_U(string p_in)
            => await _repository.CSDT_MSGB_U(p_in);

        public async Task<string> CTRG_MSGB_U(string p_in)
            => await _repository.CTRG_MSGB_U(p_in);

        public async Task<string> VIST_MSGB_U(string p_in)
            => await _repository.VIST_MSGB_U(p_in);

        public async Task<string> LIST_MSGB_U(string p_in)
            => await _repository.LIST_MSGB_U(p_in);
    }
}
