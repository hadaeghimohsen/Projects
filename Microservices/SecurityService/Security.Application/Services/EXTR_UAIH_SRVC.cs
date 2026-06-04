using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_UAIH_SRVC : IEXTR_UAIH_SRVC
    {
        private readonly IEXTR_UAIH_SRVC _repository;

        public EXTR_UAIH_SRVC(IEXTR_UAIH_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_UAIH_U(string p_in)
            => await _repository.INIT_UAIH_U(p_in);

        public async Task<string> LIST_UAIH_U(string p_in)
            => await _repository.LIST_UAIH_U(p_in);
    }
}
