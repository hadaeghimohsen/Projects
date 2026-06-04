using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_USON_CTRL : Controller
    {
        private readonly IEXTR_USON_SRVC _extrSrv;

        public EXTR_USON_CTRL(IEXTR_USON_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_USON_V")]
        public IActionResult LIST_USON_V()
        {
            return View();
        }

        [HttpPost("LIST_USON_U")]
        public async Task<IActionResult> LIST_USON_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_USON_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("USON_V")]
        public IActionResult USON_V()
        {
            return View();
        }

        [HttpPost("INIT_USON_U")]
        public async Task<IActionResult> INIT_USON_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_USON_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CRET_USON_U")]
        public async Task<IActionResult> CRET_USON_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CRET_USON_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("LOUT_USON_U")]
        public async Task<IActionResult> LOUT_USON_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LOUT_USON_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("LSEN_USON_U")]
        public async Task<IActionResult> LSEN_USON_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LSEN_USON_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("ACTV_USON_U")]
        public async Task<IActionResult> ACTV_USON_U([FromBody] string p_in)
        {
            var result = await _extrSrv.ACTV_USON_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("DACT_USON_U")]
        public async Task<IActionResult> DACT_USON_U([FromBody] string p_in)
        {
            var result = await _extrSrv.DACT_USON_U(p_in);
            return Content(result, "application/json");
        }
    }
}
