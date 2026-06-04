using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_SYSR_SRVC : IEXTR_SYSR_SRVC
    {
        private readonly IEXTR_SYSR_SRVC _repository;

        public EXTR_SYSR_SRVC(IEXTR_SYSR_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_SYSR_U(string p_in)
            => await _repository.INIT_SYSR_U(p_in);

        public async Task<string> LIST_SYSR_U(string p_in)
            => await _repository.LIST_SYSR_U(p_in);
    }
}
