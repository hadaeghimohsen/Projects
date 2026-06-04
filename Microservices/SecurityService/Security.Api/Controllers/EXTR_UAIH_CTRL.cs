using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_UAIH_CTRL : Controller
    {
        private readonly IEXTR_UAIH_SRVC _extrSrv;

        public EXTR_UAIH_CTRL(IEXTR_UAIH_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_UAIH_V")]
        public IActionResult LIST_UAIH_V()
        {
            return View();
        }

        [HttpPost("LIST_UAIH_U")]
        public async Task<IActionResult> LIST_UAIH_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_UAIH_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("UAIH_V")]
        public IActionResult UAIH_V()
        {
            return View();
        }

        [HttpPost("INIT_UAIH_U")]
        public async Task<IActionResult> INIT_UAIH_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_UAIH_U(p_in);
            return Content(result, "application/json");
        }
    }
}
