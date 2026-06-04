using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_NEWS_CTRL : Controller
    {
        private readonly IEXTR_NEWS_SRVC _extrSrv;

        public EXTR_NEWS_CTRL(IEXTR_NEWS_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_NEWS_V")]
        public IActionResult LIST_NEWS_V()
        {
            return View();
        }

        [HttpPost("LIST_NEWS_U")]
        public async Task<IActionResult> LIST_NEWS_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_NEWS_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("NEWS_V")]
        public IActionResult NEWS_V()
        {
            return View();
        }

        [HttpPost("INIT_NEWS_U")]
        public async Task<IActionResult> INIT_NEWS_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_NEWS_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CRET_NEWS_U")]
        public async Task<IActionResult> CRET_NEWS_U([FromBody] string p_in)
        {
            var result = await _extrSrv.CRET_NEWS_U(p_in);
            return Content(result, "application/json");
        }

        [HttpDelete("REMV_NEWS_U")]
        public async Task<IActionResult> REMV_NEWS_U([FromBody] string p_in)
        {
            var result = await _extrSrv.REMV_NEWS_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPut("UPDT_NEWS_U")]
        public async Task<IActionResult> UPDT_NEWS_U([FromBody] string p_in)
        {
            var result = await _extrSrv.UPDT_NEWS_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("ACTV_NEWS_U")]
        public async Task<IActionResult> ACTV_NEWS_U([FromBody] string p_in)
        {
            var result = await _extrSrv.ACTV_NEWS_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("DACT_NEWS_U")]
        public async Task<IActionResult> DACT_NEWS_U([FromBody] string p_in)
        {
            var result = await _extrSrv.DACT_NEWS_U(p_in);
            return Content(result, "application/json");
        }
    }
}
