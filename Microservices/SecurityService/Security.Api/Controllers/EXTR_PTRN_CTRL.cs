using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_PTRN_CTRL : Controller
    {
        private readonly IEXTR_PTRN_SRVC _extrSrv;

        public EXTR_PTRN_CTRL(IEXTR_PTRN_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_PTRN_V")]
        public IActionResult LIST_PTRN_V()
        {
            return View();
        }

        [HttpPost("LIST_PTRN_U")]
        public async Task<IActionResult> LIST_PTRN_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_PTRN_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("PTRN_V")]
        public IActionResult PTRN_V()
        {
            return View();
        }

        [HttpPost("INIT_PTRN_U")]
        public async Task<IActionResult> INIT_PTRN_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_PTRN_U(p_in);
            return Content(result, "application/json");
        }
    }
}
