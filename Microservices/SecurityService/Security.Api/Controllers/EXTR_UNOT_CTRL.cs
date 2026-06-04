using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Domain.Interfaces;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class EXTR_UNOT_CTRL : Controller
    {
        private readonly IEXTR_UNOT_SRVC _extrSrv;

        public EXTR_UNOT_CTRL(IEXTR_UNOT_SRVC extrSrv)
        {
            _extrSrv = extrSrv;
        }

        [HttpGet("LIST_UNOT_V")]
        public IActionResult LIST_UNOT_V()
        {
            return View();
        }

        [HttpPost("LIST_UNOT_U")]
        public async Task<IActionResult> LIST_UNOT_U([FromBody] string p_in)
        {
            var result = await _extrSrv.LIST_UNOT_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("UNOT_V")]
        public IActionResult UNOT_V()
        {
            return View();
        }

        [HttpPost("INIT_UNOT_U")]
        public async Task<IActionResult> INIT_UNOT_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INIT_UNOT_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("INBX_UNOT_U")]
        public async Task<IActionResult> INBX_UNOT_U([FromBody] string p_in)
        {
            var result = await _extrSrv.INBX_UNOT_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("READ_UNOT_U")]
        public async Task<IActionResult> READ_UNOT_U([FromBody] string p_in)
        {
            var result = await _extrSrv.READ_UNOT_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("PINT_UNOT_U")]
        public async Task<IActionResult> PINT_UNOT_U([FromBody] string p_in)
        {
            var result = await _extrSrv.PINT_UNOT_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("UPIN_UNOT_U")]
        public async Task<IActionResult> UPIN_UNOT_U([FromBody] string p_in)
        {
            var result = await _extrSrv.UPIN_UNOT_U(p_in);
            return Content(result, "application/json");
        }
    }
}
