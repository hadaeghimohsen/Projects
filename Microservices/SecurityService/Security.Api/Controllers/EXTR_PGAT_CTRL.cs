using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_PGAT_CTRL : Controller
    {
        private readonly IEXTR_PGAT_SRVC _extrSrv;

        public EXTR_PGAT_CTRL(IEXTR_PGAT_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_PGAT_V")]
        public IActionResult LIST_PGAT_V()
        {
            return View();
        }

        [HttpPost("LIST_PGAT_U")]
        public async Task<IActionResult> LIST_PGAT_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_PGAT_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("PGAT_V")]
        public IActionResult PGAT_V()
        {
            return View();
        }

        [HttpPost("INIT_PGAT_U")]
        public async Task<IActionResult> INIT_PGAT_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_PGAT_U(p_in);
            return Content(result, "application/json");
        }
    }
}
