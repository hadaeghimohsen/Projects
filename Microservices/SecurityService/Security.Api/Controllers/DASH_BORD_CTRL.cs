using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Security.Api.Controllers
{
    [Authorize]
    public class DASH_BORD_CTRL : Controller
    {
        [HttpGet]
        public IActionResult DASH_BORD_V()
        {
            return View();
        }
    }
}
