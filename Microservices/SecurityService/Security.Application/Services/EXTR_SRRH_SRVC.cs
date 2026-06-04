using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_SRRH_SRVC : IEXTR_SRRH_SRVC
    {
        private readonly IEXTR_SRRH_SRVC _repository;

        public EXTR_SRRH_SRVC(IEXTR_SRRH_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_SRRH_U(string p_in)
            => await _repository.INIT_SRRH_U(p_in);

        public async Task<string> LIST_SRRH_U(string p_in)
            => await _repository.LIST_SRRH_U(p_in);
    }
}
