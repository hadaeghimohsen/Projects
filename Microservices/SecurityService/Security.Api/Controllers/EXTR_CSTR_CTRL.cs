using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_CSTR_CTRL : Controller
    {
        private readonly IEXTR_CSTR_SRVC _extrSrv;

        public EXTR_CSTR_CTRL(IEXTR_CSTR_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_CSTR_V")]
        public IActionResult LIST_CSTR_V()
        {
            return View();
        }

        [HttpPost("LIST_CSTR_U")]
        public async Task<IActionResult> LIST_CSTR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_CSTR_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("CSTR_V")]
        public IActionResult CSTR_V()
        {
            return View();
        }

        [HttpPost("INIT_CSTR_U")]
        public async Task<IActionResult> INIT_CSTR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_CSTR_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CRET_CSTR_U")]
        public async Task<IActionResult> CRET_CSTR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CRET_CSTR_U(p_in);
            return Content(result, "application/json");
        }

        [HttpDelete("REMV_CSTR_U")]
        public async Task<IActionResult> REMV_CSTR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.REMV_CSTR_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("ACTV_CSTR_U")]
        public async Task<IActionResult> ACTV_CSTR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.ACTV_CSTR_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("DACT_CSTR_U")]
        public async Task<IActionResult> DACT_CSTR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.DACT_CSTR_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("GET_CSTR_U")]
        public async Task<IActionResult> GET_CSTR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.GET_CSTR_U(p_in);
            return Content(result, "application/json");
        }
    }
}
