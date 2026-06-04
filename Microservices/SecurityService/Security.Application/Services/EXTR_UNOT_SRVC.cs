using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_UNOT_SRVC : IEXTR_UNOT_SRVC
    {
        private readonly IEXTR_UNOT_SRVC _repository;

        public EXTR_UNOT_SRVC(IEXTR_UNOT_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_UNOT_U(string p_in)
            => await _repository.INIT_UNOT_U(p_in);

        public async Task<string> INBX_UNOT_U(string p_in)
            => await _repository.INBX_UNOT_U(p_in);

        public async Task<string> READ_UNOT_U(string p_in)
            => await _repository.READ_UNOT_U(p_in);

        public async Task<string> PINT_UNOT_U(string p_in)
            => await _repository.PINT_UNOT_U(p_in);

        public async Task<string> UPIN_UNOT_U(string p_in)
            => await _repository.UPIN_UNOT_U(p_in);

        public async Task<string> LIST_UNOT_U(string p_in)
            => await _repository.LIST_UNOT_U(p_in);
    }
}
