using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_UAIN_CTRL : Controller
    {
        private readonly IEXTR_UAIN_SRVC _extrSrv;

        public EXTR_UAIN_CTRL(IEXTR_UAIN_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_UAIN_V")]
        public IActionResult LIST_UAIN_V()
        {
            return View();
        }

        [HttpPost("LIST_UAIN_U")]
        public async Task<IActionResult> LIST_UAIN_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_UAIN_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("UAIN_V")]
        public IActionResult UAIN_V()
        {
            return View();
        }

        [HttpPost("INIT_UAIN_U")]
        public async Task<IActionResult> INIT_UAIN_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_UAIN_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("COPY_UAIN_U")]
        public async Task<IActionResult> COPY_UAIN_U([FromBody] string p_in)
        {
            var result = await _extrSrv.COPY_UAIN_U(p_in);
            return Content(result, "application/json");
        }
    }
}
