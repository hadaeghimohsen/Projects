using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_ASDM_CTRL : Controller
    {
        private readonly IEXTR_ASDM_SRVC _extrSrv;

        public EXTR_ASDM_CTRL(IEXTR_ASDM_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_ASDM_V")]
        public IActionResult LIST_ASDM_V()
        {
            return View();
        }

        [HttpPost("LIST_ASDM_U")]
        public async Task<IActionResult> LIST_ASDM_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_ASDM_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("ASDM_V")]
        public IActionResult ASDM_V()
        {
            return View();
        }

        [HttpPost("INIT_ASDM_U")]
        public async Task<IActionResult> INIT_ASDM_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_ASDM_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CRET_ASDM_U")]
        public async Task<IActionResult> CRET_ASDM_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CRET_ASDM_U(p_in);
            return Content(result, "application/json");
        }

        [HttpDelete("REMV_ASDM_U")]
        public async Task<IActionResult> REMV_ASDM_U([FromBody] string p_in)
        {
            var result = await _extrSrv.REMV_ASDM_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPut("UPDT_ASDM_U")]
        public async Task<IActionResult> UPDT_ASDM_U([FromBody] string p_in)
        {
            var result = await _extrSrv.UPDT_ASDM_U(p_in);
            return Content(result, "application/json");
        }
    }
}
