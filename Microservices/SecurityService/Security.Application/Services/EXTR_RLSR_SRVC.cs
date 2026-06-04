using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_RLSR_SRVC : IEXTR_RLSR_SRVC
    {
        private readonly IEXTR_RLSR_SRVC _repository;

        public EXTR_RLSR_SRVC(IEXTR_RLSR_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_RLSR_U(string p_in)
            => await _repository.INIT_RLSR_U(p_in);

        public async Task<string> LIST_RLSR_U(string p_in)
            => await _repository.LIST_RLSR_U(p_in);
    }
}
