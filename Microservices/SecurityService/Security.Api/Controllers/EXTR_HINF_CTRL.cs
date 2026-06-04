using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_HINF_CTRL : Controller
    {
        private readonly IEXTR_HINF_SRVC _extrSrv;

        public EXTR_HINF_CTRL(IEXTR_HINF_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_HINF_V")]
        public IActionResult LIST_HINF_V()
        {
            return View();
        }

        [HttpPost("LIST_HINF_U")]
        public async Task<IActionResult> LIST_HINF_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_HINF_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("HINF_V")]
        public IActionResult HINF_V()
        {
            return View();
        }

        [HttpPost("INIT_HINF_U")]
        public async Task<IActionResult> INIT_HINF_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_HINF_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("REGS_HINF_U")]
        public async Task<IActionResult> REGS_HINF_U([FromBody] string p_in)
        {
            var result = await _extrSrv.REGS_HINF_U(p_in);
            return Content(result, "application/json");
        }
    }
}
