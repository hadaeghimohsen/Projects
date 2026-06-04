using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_SYSR_CTRL : Controller
    {
        private readonly IEXTR_SYSR_SRVC _extrSrv;

        public EXTR_SYSR_CTRL(IEXTR_SYSR_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_SYSR_V")]
        public IActionResult LIST_SYSR_V()
        {
            return View();
        }

        [HttpPost("LIST_SYSR_U")]
        public async Task<IActionResult> LIST_SYSR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_SYSR_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("SYSR_V")]
        public IActionResult SYSR_V()
        {
            return View();
        }

        [HttpPost("INIT_SYSR_U")]
        public async Task<IActionResult> INIT_SYSR_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_SYSR_U(p_in);
            return Content(result, "application/json");
        }
    }
}
