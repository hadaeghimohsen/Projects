using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_URTK_SRVC : IEXTR_URTK_SRVC
    {
        private readonly IEXTR_URTK_SRVC _repository;

        public EXTR_URTK_SRVC(IEXTR_URTK_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_URTK_U(string p_in)
            => await _repository.INIT_URTK_U(p_in);

        public async Task<string> LIST_URTK_U(string p_in)
            => await _repository.LIST_URTK_U(p_in);
    }
}
