using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_GPUA_CTRL : Controller
    {
        private readonly IEXTR_GPUA_SRVC _extrSrv;

        public EXTR_GPUA_CTRL(IEXTR_GPUA_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_GPUA_V")]
        public IActionResult LIST_GPUA_V()
        {
            return View();
        }

        [HttpPost("LIST_GPUA_U")]
        public async Task<IActionResult> LIST_GPUA_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_GPUA_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("GPUA_V")]
        public IActionResult GPUA_V()
        {
            return View();
        }

        [HttpPost("INIT_GPUA_U")]
        public async Task<IActionResult> INIT_GPUA_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_GPUA_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("JOIN_GPUA_U")]
        public async Task<IActionResult> JOIN_GPUA_U([FromBody] string p_in)
        {
            var result = await _extrSrv.JOIN_GPUA_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("LEFT_GPUA_U")]
        public async Task<IActionResult> LEFT_GPUA_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LEFT_GPUA_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("ACTV_GPUA_U")]
        public async Task<IActionResult> ACTV_GPUA_U([FromBody] string p_in)
        {
            var result = await _extrSrv.ACTV_GPUA_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("DACV_GPUA_U")]
        public async Task<IActionResult> DACV_GPUA_U([FromBody] string p_in)
        {
            var result = await _extrSrv.DACV_GPUA_U(p_in);
            return Content(result, "application/json");
        }
    }
}
