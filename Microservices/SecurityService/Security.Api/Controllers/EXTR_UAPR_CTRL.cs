using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_UAPR_CTRL : Controller
    {
        private readonly IEXTR_UAPR_SRVC _extrSrv;

        public EXTR_UAPR_CTRL(IEXTR_UAPR_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_UAPR_V")]
        public IActionResult LIST_UAPR_V()
        {
            return View();
        }

        [HttpPost("LIST_UAPR_U")]
        public async Task<IActionResult> LIST_UAPR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_UAPR_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("UAPR_V")]
        public IActionResult UAPR_V()
        {
            return View();
        }

        [HttpPost("INIT_UAPR_U")]
        public async Task<IActionResult> INIT_UAPR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_UAPR_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("GRNT_UAPR_U")]
        public async Task<IActionResult> GRNT_UAPR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.GRNT_UAPR_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("RVOK_UAPR_U")]
        public async Task<IActionResult> RVOK_UAPR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.RVOK_UAPR_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CHCK_UAPR_U")]
        public async Task<IActionResult> CHCK_UAPR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CHCK_UAPR_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("COPY_UAPR_U")]
        public async Task<IActionResult> COPY_UAPR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.COPY_UAPR_U(p_in);
            return Content(result, "application/json");
        }
    }
}
