using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_GPUA_SRVC : IEXTR_GPUA_SRVC
    {
        private readonly IEXTR_GPUA_SRVC _repository;

        public EXTR_GPUA_SRVC(IEXTR_GPUA_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_GPUA_U(string p_in)
            => await _repository.INIT_GPUA_U(p_in);

        public async Task<string> JOIN_GPUA_U(string p_in)
            => await _repository.JOIN_GPUA_U(p_in);

        public async Task<string> LEFT_GPUA_U(string p_in)
            => await _repository.LEFT_GPUA_U(p_in);

        public async Task<string> ACTV_GPUA_U(string p_in)
            => await _repository.ACTV_GPUA_U(p_in);

        public async Task<string> DACV_GPUA_U(string p_in)
            => await _repository.DACV_GPUA_U(p_in);

        public async Task<string> LIST_GPUA_U(string p_in)
            => await _repository.LIST_GPUA_U(p_in);
    }
}
