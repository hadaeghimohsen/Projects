using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_SRRH_CTRL : Controller
    {
        private readonly IEXTR_SRRH_SRVC _extrSrv;

        public EXTR_SRRH_CTRL(IEXTR_SRRH_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_SRRH_V")]
        public IActionResult LIST_SRRH_V()
        {
            return View();
        }

        [HttpPost("LIST_SRRH_U")]
        public async Task<IActionResult> LIST_SRRH_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_SRRH_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("SRRH_V")]
        public IActionResult SRRH_V()
        {
            return View();
        }

        [HttpPost("INIT_SRRH_U")]
        public async Task<IActionResult> INIT_SRRH_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_SRRH_U(p_in);
            return Content(result, "application/json");
        }
    }
}
