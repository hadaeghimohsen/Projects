using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_MSGB_CTRL : Controller
    {
        private readonly IEXTR_MSGB_SRVC _extrSrv;

        public EXTR_MSGB_CTRL(IEXTR_MSGB_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_MSGB_V")]
        public IActionResult LIST_MSGB_V()
        {
            return View();
        }

        [HttpPost("LIST_MSGB_U")]
        public async Task<IActionResult> LIST_MSGB_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_MSGB_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("MSGB_V")]
        public IActionResult MSGB_V()
        {
            return View();
        }

        [HttpPost("INIT_MSGB_U")]
        public async Task<IActionResult> INIT_MSGB_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_MSGB_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CRET_MSGB_U")]
        public async Task<IActionResult> CRET_MSGB_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CRET_MSGB_U(p_in);
            return Content(result, "application/json");
        }

        [HttpDelete("REMV_MSGB_U")]
        public async Task<IActionResult> REMV_MSGB_U([FromBody] string p_in)
        {
            var result = await _extrSrv.REMV_MSGB_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPut("UPDT_MSGB_U")]
        public async Task<IActionResult> UPDT_MSGB_U([FromBody] string p_in)
        {
            var result = await _extrSrv.UPDT_MSGB_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("ACTV_MSGB_U")]
        public async Task<IActionResult> ACTV_MSGB_U([FromBody] string p_in)
        {
            var result = await _extrSrv.ACTV_MSGB_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("DACT_MSGB_U")]
        public async Task<IActionResult> DACT_MSGB_U([FromBody] string p_in)
        {
            var result = await _extrSrv.DACT_MSGB_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CSDT_MSGB_U")]
        public async Task<IActionResult> CSDT_MSGB_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CSDT_MSGB_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CTRG_MSGB_U")]
        public async Task<IActionResult> CTRG_MSGB_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CTRG_MSGB_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("VIST_MSGB_U")]
        public async Task<IActionResult> VIST_MSGB_U([FromBody] string p_in)
        {
            var result = await _extrSrv.VIST_MSGB_U(p_in);
            return Content(result, "application/json");
        }
    }
}
