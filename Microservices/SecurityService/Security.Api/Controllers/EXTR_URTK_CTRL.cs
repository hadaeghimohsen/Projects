using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_URTK_CTRL : Controller
    {
        private readonly IEXTR_URTK_SRVC _extrSrv;

        public EXTR_URTK_CTRL(IEXTR_URTK_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_URTK_V")]
        public IActionResult LIST_URTK_V()
        {
            return View();
        }

        [HttpPost("LIST_URTK_U")]
        public async Task<IActionResult> LIST_URTK_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_URTK_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("URTK_V")]
        public IActionResult URTK_V()
        {
            return View();
        }

        [HttpPost("INIT_URTK_U")]
        public async Task<IActionResult> INIT_URTK_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_URTK_U(p_in);
            return Content(result, "application/json");
        }
    }
}
