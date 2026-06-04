using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_UIMG_CTRL : Controller
    {
        private readonly IEXTR_UIMG_SRVC _extrSrv;

        public EXTR_UIMG_CTRL(IEXTR_UIMG_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_UIMG_V")]
        public IActionResult LIST_UIMG_V()
        {
            return View();
        }

        [HttpPost("LIST_UIMG_U")]
        public async Task<IActionResult> LIST_UIMG_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_UIMG_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("UIMG_V")]
        public IActionResult UIMG_V()
        {
            return View();
        }

        [HttpPost("INIT_UIMG_U")]
        public async Task<IActionResult> INIT_UIMG_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_UIMG_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("UPLD_UIMG_U")]
        public async Task<IActionResult> UPLD_UIMG_U([FromBody] string p_in)
        {
            var result = await _extrSrv.UPLD_UIMG_U(p_in);
            return Content(result, "application/json");
        }

        [HttpDelete("REMV_UIMG_U")]
        public async Task<IActionResult> REMV_UIMG_U([FromBody] string p_in)
        {
            var result = await _extrSrv.REMV_UIMG_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPut("UPDT_UIMG_U")]
        public async Task<IActionResult> UPDT_UIMG_U([FromBody] string p_in)
        {
            var result = await _extrSrv.UPDT_UIMG_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("ACTV_UIMG_U")]
        public async Task<IActionResult> ACTV_UIMG_U([FromBody] string p_in)
        {
            var result = await _extrSrv.ACTV_UIMG_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("DACT_UIMG_U")]
        public async Task<IActionResult> DACT_UIMG_U([FromBody] string p_in)
        {
            var result = await _extrSrv.DACT_UIMG_U(p_in);
            return Content(result, "application/json");
        }
    }
}
