using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_GROP_CTRL : Controller
    {
        private readonly IEXTR_GROP_SRVC _extrSrv;

        public EXTR_GROP_CTRL(IEXTR_GROP_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_GROP_V")]
        public IActionResult LIST_GROP_V()
        {
            return View();
        }

        [HttpPost("LIST_GROP_U")]
        public async Task<IActionResult> LIST_GROP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_GROP_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("GROP_V")]
        public IActionResult GROP_V()
        {
            return View();
        }

        [HttpPost("INIT_GROP_U")]
        public async Task<IActionResult> INIT_GROP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_GROP_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CRET_GROP_U")]
        public async Task<IActionResult> CRET_GROP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CRET_GROP_U(p_in);
            return Content(result, "application/json");
        }

        [HttpDelete("REMV_GROP_U")]
        public async Task<IActionResult> REMV_GROP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.REMV_GROP_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPut("UPDT_GROP_U")]
        public async Task<IActionResult> UPDT_GROP_U([FromBody] string p_in)
        {
            var result = await _extrSrv.UPDT_GROP_U(p_in);
            return Content(result, "application/json");
        }
    }
}
