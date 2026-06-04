using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_CSTR_SRVC : IEXTR_CSTR_SRVC
    {
        private readonly IEXTR_CSTR_SRVC _repository;

        public EXTR_CSTR_SRVC(IEXTR_CSTR_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_CSTR_U(string p_in)
            => await _repository.INIT_CSTR_U(p_in);

        public async Task<string> CRET_CSTR_U(string p_in)
            => await _repository.CRET_CSTR_U(p_in);

        public async Task<string> REMV_CSTR_U(string p_in)
            => await _repository.REMV_CSTR_U(p_in);

        public async Task<string> ACTV_CSTR_U(string p_in)
            => await _repository.ACTV_CSTR_U(p_in);

        public async Task<string> DACT_CSTR_U(string p_in)
            => await _repository.DACT_CSTR_U(p_in);

        public async Task<string> GET_CSTR_U(string p_in)
            => await _repository.GET_CSTR_U(p_in);

        public async Task<string> LIST_CSTR_U(string p_in)
            => await _repository.LIST_CSTR_U(p_in);
    }
}
