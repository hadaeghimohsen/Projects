using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_ROLP_CTRL : Controller
    {
        private readonly IEXTR_ROLP_SRVC _extrSrv;

        public EXTR_ROLP_CTRL(IEXTR_ROLP_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_ROLP_V")]
        public IActionResult LIST_ROLP_V()
        {
            return View();
        }

        [HttpPost("LIST_ROLP_U")]
        public async Task<IActionResult> LIST_ROLP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_ROLP_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("ROLP_V")]
        public IActionResult ROLP_V()
        {
            return View();
        }

        [HttpPost("INIT_ROLP_U")]
        public async Task<IActionResult> INIT_ROLP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_ROLP_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("GRNT_ROLP_U")]
        public async Task<IActionResult> GRNT_ROLP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.GRNT_ROLP_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("RVOK_ROLP_U")]
        public async Task<IActionResult> RVOK_ROLP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.RVOK_ROLP_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CHCK_ROLP_U")]
        public async Task<IActionResult> CHCK_ROLP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CHCK_ROLP_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("COPY_ROLP_U")]
        public async Task<IActionResult> COPY_ROLP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.COPY_ROLP_U(p_in);
            return Content(result, "application/json");
        }
    }
}
