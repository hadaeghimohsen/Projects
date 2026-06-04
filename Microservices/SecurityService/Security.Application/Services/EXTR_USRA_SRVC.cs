using Security.Domain.Interfaces;

namespace Security.Application.Services
{
    public class EXTR_USRA_SRVC : IEXTR_USRA_SRVC
    {
        private readonly IEXTR_USRA_SRVC _repository;

        public EXTR_USRA_SRVC(IEXTR_USRA_SRVC repository)
        {
            _repository = repository;
        }

        public async Task<string> INIT_USRA_U(string p_in)
            => await _repository.INIT_USRA_U(p_in);

        public async Task<string> LGIN_USRA_U(string p_in)
            => await _repository.LGIN_USRA_U(p_in);

        public async Task<string> LGOT_USRA_U(string p_in)
            => await _repository.LGOT_USRA_U(p_in);

        public async Task<string> CRET_USRA_U(string p_in)
            => await _repository.CRET_USRA_U(p_in);

        public async Task<string> REMV_USRA_U(string p_in)
            => await _repository.REMV_USRA_U(p_in);

        public async Task<string> UPDT_USRA_U(string p_in)
            => await _repository.UPDT_USRA_U(p_in);

        public async Task<string> ACTV_USRA_U(string p_in)
            => await _repository.ACTV_USRA_U(p_in);

        public async Task<string> DACT_USRA_U(string p_in)
            => await _repository.DACT_USRA_U(p_in);

        public async Task<string> UPDT_PSWD_U(string p_in)
            => await _repository.UPDT_PSWD_U(p_in);

        public async Task<string> UPDT_PINC_U(string p_in)
            => await _repository.UPDT_PINC_U(p_in);

        public async Task<string> DUPL_USRA_U(string p_in)
            => await _repository.DUPL_USRA_U(p_in);

        public async Task<string> CHCK_PRIV_U(string p_in)
            => await _repository.CHCK_PRIV_U(p_in);

        public async Task<string> ENBL_TOTP_U(string p_in)
            => await _repository.ENBL_TOTP_U(p_in);

        public async Task<string> DSBL_TOTP_U(string p_in)
            => await _repository.DSBL_TOTP_U(p_in);

        public async Task<string> GETP_USRA_U(string p_in)
            => await _repository.GETP_USRA_U(p_in);

        public async Task<string> LIST_USRA_U(string p_in)
            => await _repository.LIST_USRA_U(p_in);
    }
}