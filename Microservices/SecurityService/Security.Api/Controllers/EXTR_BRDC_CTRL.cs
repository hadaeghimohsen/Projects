using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_BRDC_CTRL : Controller
    {
        private readonly IEXTR_BRDC_SRVC _extrSrv;

        public EXTR_BRDC_CTRL(IEXTR_BRDC_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_BRDC_V")]
        public IActionResult LIST_BRDC_V()
        {
            return View();
        }

        [HttpPost("LIST_BRDC_U")]
        public async Task<IActionResult> LIST_BRDC_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_BRDC_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("BRDC_V")]
        public IActionResult BRDC_V()
        {
            return View();
        }

        [HttpPost("INIT_BRDC_U")]
        public async Task<IActionResult> INIT_BRDC_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_BRDC_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CRET_BRDC_U")]
        public async Task<IActionResult> CRET_BRDC_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CRET_BRDC_U(p_in);
            return Content(result, "application/json");
        }

        [HttpDelete("REMV_BRDC_U")]
        public async Task<IActionResult> REMV_BRDC_U([FromBody] string p_in)
        {
            var result = await _extrSrv.REMV_BRDC_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPut("UPDT_BRDC_U")]
        public async Task<IActionResult> UPDT_BRDC_U([FromBody] string p_in)
        {
            var result = await _extrSrv.UPDT_BRDC_U(p_in);
            return Content(result, "application/json");
        }
    }
}
