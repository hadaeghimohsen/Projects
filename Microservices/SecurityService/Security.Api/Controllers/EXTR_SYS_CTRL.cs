using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_SYS_CTRL : Controller
    {
        private readonly IEXTR_SYS_SRVC _extrSrv;

        public EXTR_SYS_CTRL(IEXTR_SYS_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_SYS_V")]
        public IActionResult LIST_SYS_V()
        {
            return View();
        }

        [HttpPost("LIST_SYS_U")]
        public async Task<IActionResult> LIST_SYS_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_SYS_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("SYS_V")]
        public IActionResult SYS_V()
        {
            return View();
        }

        [HttpPost("INIT_SYS_U")]
        public async Task<IActionResult> INIT_SYS_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_SYS_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CRET_SYS_U")]
        public async Task<IActionResult> CRET_SYS_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CRET_SYS_U(p_in);
            return Content(result, "application/json");
        }

        [HttpDelete("REMV_SYS_U")]
        public async Task<IActionResult> REMV_SYS_U([FromBody] string p_in)
        {
            var result = await _extrSrv.REMV_SYS_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPut("UPDT_SYS_U")]
        public async Task<IActionResult> UPDT_SYS_U([FromBody] string p_in)
        {
            var result = await _extrSrv.UPDT_SYS_U(p_in);
            return Content(result, "application/json");
        }
    }
}
