using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_GROP_SRVC : IEXTR_GROP_SRVC
    {
        private readonly IEXTR_GROP_SRVC _repository;

        public EXTR_GROP_SRVC(IEXTR_GROP_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_GROP_U(string p_in)
            => await _repository.INIT_GROP_U(p_in);

        public async Task<string> CRET_GROP_U(string p_in)
            => await _repository.CRET_GROP_U(p_in);

        public async Task<string> REMV_GROP_U(string p_in)
            => await _repository.REMV_GROP_U(p_in);

        public async Task<string> UPDT_GROP_U(string p_in)
            => await _repository.UPDT_GROP_U(p_in);

        public async Task<string> LIST_GROP_U(string p_in)
            => await _repository.LIST_GROP_U(p_in);
    }
}
