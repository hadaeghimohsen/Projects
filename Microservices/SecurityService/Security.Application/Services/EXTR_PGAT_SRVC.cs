using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_PGAT_SRVC : IEXTR_PGAT_SRVC
    {
        private readonly IEXTR_PGAT_SRVC _repository;

        public EXTR_PGAT_SRVC(IEXTR_PGAT_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_PGAT_U(string p_in)
            => await _repository.INIT_PGAT_U(p_in);

        public async Task<string> LIST_PGAT_U(string p_in)
            => await _repository.LIST_PGAT_U(p_in);
    }
}
