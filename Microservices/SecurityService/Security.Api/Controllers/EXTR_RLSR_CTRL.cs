using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_RLSR_CTRL : Controller
    {
        private readonly IEXTR_RLSR_SRVC _extrSrv;

        public EXTR_RLSR_CTRL(IEXTR_RLSR_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_RLSR_V")]
        public IActionResult LIST_RLSR_V()
        {
            return View();
        }

        [HttpPost("LIST_RLSR_U")]
        public async Task<IActionResult> LIST_RLSR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_RLSR_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("RLSR_V")]
        public IActionResult RLSR_V()
        {
            return View();
        }

        [HttpPost("INIT_RLSR_U")]
        public async Task<IActionResult> INIT_RLSR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_RLSR_U(p_in);
            return Content(result, "application/json");
        }
    }
}
