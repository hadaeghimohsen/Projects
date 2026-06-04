using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_ROLE_CTRL : Controller
    {
        private readonly IEXTR_ROLE_SRVC _extrSrv;

        public EXTR_ROLE_CTRL(IEXTR_ROLE_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_ROLE_V")]
        public IActionResult LIST_ROLE_V()
        {
            return View();
        }

        [HttpPost("LIST_ROLE_U")]
        public async Task<IActionResult> LIST_ROLE_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_ROLE_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("ROLE_V")]
        public IActionResult ROLE_V()
        {
            return View();
        }

        [HttpPost("INIT_ROLE_U")]
        public async Task<IActionResult> INIT_ROLE_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_ROLE_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CRET_ROLE_U")]
        public async Task<IActionResult> CRET_ROLE_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CRET_ROLE_U(p_in);
            return Content(result, "application/json");
        }

        [HttpDelete("REMV_ROLE_U")]
        public async Task<IActionResult> REMV_ROLE_U([FromBody] string p_in)
        {
            var result = await _extrSrv.REMV_ROLE_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPut("UPDT_ROLE_U")]
        public async Task<IActionResult> UPDT_ROLE_U([FromBody] string p_in)
        {
            var result = await _extrSrv.UPDT_ROLE_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("ACTV_ROLE_U")]
        public async Task<IActionResult> ACTV_ROLE_U([FromBody] string p_in)
        {
            var result = await _extrSrv.ACTV_ROLE_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("DACT_ROLE_U")]
        public async Task<IActionResult> DACT_ROLE_U([FromBody] string p_in)
        {
            var result = await _extrSrv.DACT_ROLE_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("DUPL_ROLE_U")]
        public async Task<IActionResult> DUPL_ROLE_U([FromBody] string p_in)
        {
            var result = await _extrSrv.DUPL_ROLE_U(p_in);
            return Content(result, "application/json");
        }
    }
}
