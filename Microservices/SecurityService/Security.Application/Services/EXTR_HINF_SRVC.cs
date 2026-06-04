using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_HINF_SRVC : IEXTR_HINF_SRVC
    {
        private readonly IEXTR_HINF_SRVC _repository;

        public EXTR_HINF_SRVC(IEXTR_HINF_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_HINF_U(string p_in)
            => await _repository.INIT_HINF_U(p_in);

        public async Task<string> REGS_HINF_U(string p_in)
            => await _repository.REGS_HINF_U(p_in);

        public async Task<string> LIST_HINF_U(string p_in)
            => await _repository.LIST_HINF_U(p_in);
    }
}
