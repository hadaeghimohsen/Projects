using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_PTRN_SRVC : IEXTR_PTRN_SRVC
    {
        private readonly IEXTR_PTRN_SRVC _repository;

        public EXTR_PTRN_SRVC(IEXTR_PTRN_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_PTRN_U(string p_in)
            => await _repository.INIT_PTRN_U(p_in);

        public async Task<string> LIST_PTRN_U(string p_in)
            => await _repository.LIST_PTRN_U(p_in);
    }
}
