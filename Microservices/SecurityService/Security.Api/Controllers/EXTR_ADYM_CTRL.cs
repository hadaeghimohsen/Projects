using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_ADYM_CTRL : Controller
    {
        private readonly IEXTR_ADYM_SRVC _extrSrv;

        public EXTR_ADYM_CTRL(IEXTR_ADYM_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_ADYM_V")]
        public IActionResult LIST_ADYM_V()
        {
            return View();
        }

        [HttpPost("LIST_ADYM_U")]
        public async Task<IActionResult> LIST_ADYM_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_ADYM_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("ADYM_V")]
        public IActionResult ADYM_V()
        {
            return View();
        }

        [HttpPost("INIT_ADYM_U")]
        public async Task<IActionResult> INIT_ADYM_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_ADYM_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CRET_ADYM_U")]
        public async Task<IActionResult> CRET_ADYM_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CRET_ADYM_U(p_in);
            return Content(result, "application/json");
        }

        [HttpDelete("REMV_ADYM_U")]
        public async Task<IActionResult> REMV_ADYM_U([FromBody] string p_in)
        {
            var result = await _extrSrv.REMV_ADYM_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPut("UPDT_ADYM_U")]
        public async Task<IActionResult> UPDT_ADYM_U([FromBody] string p_in)
        {
            var result = await _extrSrv.UPDT_ADYM_U(p_in);
            return Content(result, "application/json");
        }
    }
}
