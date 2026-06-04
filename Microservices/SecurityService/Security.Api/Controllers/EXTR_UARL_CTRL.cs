using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_UARL_CTRL : Controller
    {
        private readonly IEXTR_UARL_SRVC _extrSrv;

        public EXTR_UARL_CTRL(IEXTR_UARL_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_UARL_V")]
        public IActionResult LIST_UARL_V()
        {
            return View();
        }

        [HttpPost("LIST_UARL_U")]
        public async Task<IActionResult> LIST_UARL_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_UARL_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("UARL_V")]
        public IActionResult UARL_V()
        {
            return View();
        }

        [HttpPost("INIT_UARL_U")]
        public async Task<IActionResult> INIT_UARL_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_UARL_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("GRNT_UARL_U")]
        public async Task<IActionResult> GRNT_UARL_U([FromBody] string p_in)
        {
            var result = await _extrSrv.GRNT_UARL_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("RVOK_UARL_U")]
        public async Task<IActionResult> RVOK_UARL_U([FromBody] string p_in)
        {
            var result = await _extrSrv.RVOK_UARL_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CHCK_UARL_U")]
        public async Task<IActionResult> CHCK_UARL_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CHCK_UARL_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("COPY_UARL_U")]
        public async Task<IActionResult> COPY_UARL_U([FromBody] string p_in)
        {
            var result = await _extrSrv.COPY_UARL_U(p_in);
            return Content(result, "application/json");
        }
    }
}
