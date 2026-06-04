using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_DSRC_CTRL : Controller
    {
        private readonly IEXTR_DSRC_SRVC _extrSrv;

        public EXTR_DSRC_CTRL(IEXTR_DSRC_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_DSRC_V")]
        public IActionResult LIST_DSRC_V()
        {
            return View();
        }

        [HttpPost("LIST_DSRC_U")]
        public async Task<IActionResult> LIST_DSRC_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_DSRC_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("DSRC_V")]
        public IActionResult DSRC_V()
        {
            return View();
        }

        [HttpPost("INIT_DSRC_U")]
        public async Task<IActionResult> INIT_DSRC_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_DSRC_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CRET_DSRC_U")]
        public async Task<IActionResult> CRET_DSRC_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CRET_DSRC_U(p_in);
            return Content(result, "application/json");
        }

        [HttpDelete("REMV_DSRC_U")]
        public async Task<IActionResult> REMV_DSRC_U([FromBody] string p_in)
        {
            var result = await _extrSrv.REMV_DSRC_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPut("UPDT_DSRC_U")]
        public async Task<IActionResult> UPDT_DSRC_U([FromBody] string p_in)
        {
            var result = await _extrSrv.UPDT_DSRC_U(p_in);
            return Content(result, "application/json");
        }
    }
}
