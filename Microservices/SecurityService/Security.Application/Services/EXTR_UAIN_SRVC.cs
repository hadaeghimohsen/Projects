using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_UAIN_SRVC : IEXTR_UAIN_SRVC
    {
        private readonly IEXTR_UAIN_SRVC _repository;

        public EXTR_UAIN_SRVC(IEXTR_UAIN_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_UAIN_U(string p_in)
            => await _repository.INIT_UAIN_U(p_in);

        public async Task<string> LIST_UAIN_U(string p_in)
            => await _repository.LIST_UAIN_U(p_in);

        public async Task<string> COPY_UAIN_U(string p_in)
            => await _repository.COPY_UAIN_U(p_in);
    }
}
