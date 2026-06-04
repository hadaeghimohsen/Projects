using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_BOXP_CTRL : Controller
    {
        private readonly IEXTR_BOXP_SRVC _extrSrv;

        public EXTR_BOXP_CTRL(IEXTR_BOXP_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_BOXP_V")]
        public IActionResult LIST_BOXP_V()
        {
            return View();
        }

        [HttpPost("LIST_BOXP_U")]
        public async Task<IActionResult> LIST_BOXP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_BOXP_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("BOXP_V")]
        public IActionResult BOXP_V()
        {
            return View();
        }

        [HttpPost("INIT_BOXP_U")]
        public async Task<IActionResult> INIT_BOXP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_BOXP_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CRET_BOXP_U")]
        public async Task<IActionResult> CRET_BOXP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CRET_BOXP_U(p_in);
            return Content(result, "application/json");
        }

        [HttpDelete("REMV_BOXP_U")]
        public async Task<IActionResult> REMV_BOXP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.REMV_BOXP_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPut("UPDT_BOXP_U")]
        public async Task<IActionResult> UPDT_BOXP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.UPDT_BOXP_U(p_in);
            return Content(result, "application/json");
        }
    }
}
