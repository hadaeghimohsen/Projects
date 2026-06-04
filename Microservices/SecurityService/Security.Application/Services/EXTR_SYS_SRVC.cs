using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_SYS_SRVC : IEXTR_SYS_SRVC
    {
        private readonly IEXTR_SYS_SRVC _repository;

        public EXTR_SYS_SRVC(IEXTR_SYS_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_SYS_U(string p_in)
            => await _repository.INIT_SYS_U(p_in);

        public async Task<string> CRET_SYS_U(string p_in)
            => await _repository.CRET_SYS_U(p_in);

        public async Task<string> REMV_SYS_U(string p_in)
            => await _repository.REMV_SYS_U(p_in);

        public async Task<string> UPDT_SYS_U(string p_in)
            => await _repository.UPDT_SYS_U(p_in);

        public async Task<string> LIST_SYS_U(string p_in)
            => await _repository.LIST_SYS_U(p_in);
    }
}
