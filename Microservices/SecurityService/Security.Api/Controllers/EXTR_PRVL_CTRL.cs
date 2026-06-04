using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_PRVL_CTRL : Controller
    {
        private readonly IEXTR_PRVL_SRVC _extrSrv;

        public EXTR_PRVL_CTRL(IEXTR_PRVL_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_PRVL_V")]
        public IActionResult LIST_PRVL_V()
        {
            return View();
        }

        [HttpPost("LIST_PRVL_U")]
        public async Task<IActionResult> LIST_PRVL_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_PRVL_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("PRVL_V")]
        public IActionResult PRVL_V()
        {
            return View();
        }

        [HttpPost("INIT_PRVL_U")]
        public async Task<IActionResult> INIT_PRVL_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_PRVL_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CRET_PRVL_U")]
        public async Task<IActionResult> CRET_PRVL_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CRET_PRVL_U(p_in);
            return Content(result, "application/json");
        }

        [HttpDelete("REMV_PRVL_U")]
        public async Task<IActionResult> REMV_PRVL_U([FromBody] string p_in)
        {
            var result = await _extrSrv.REMV_PRVL_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPut("UPDT_PRVL_U")]
        public async Task<IActionResult> UPDT_PRVL_U([FromBody] string p_in)
        {
            var result = await _extrSrv.UPDT_PRVL_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("ACTV_PRVL_U")]
        public async Task<IActionResult> ACTV_PRVL_U([FromBody] string p_in)
        {
            var result = await _extrSrv.ACTV_PRVL_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("DACT_PRVL_U")]
        public async Task<IActionResult> DACT_PRVL_U([FromBody] string p_in)
        {
            var result = await _extrSrv.DACT_PRVL_U(p_in);
            return Content(result, "application/json");
        }
    }
}
