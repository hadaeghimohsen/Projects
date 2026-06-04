using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Application.Dtos;
using Security.Application.Interfaces;
using Security.Domain.Interfaces;
using System.Security.Claims;
using System.Text.Json;

namespace Security.Api.Controllers
{
    [Route("[controller]")]
    public class EXTR_USRA_CTRL : Controller
    {
        private readonly IEXTR_USRA_SRVC _extrUsraSrv;
        private readonly ITokenService _tokenService;

        public EXTR_USRA_CTRL(IEXTR_USRA_SRVC extrUsraSrv, ITokenService tokenService)
        {
            _extrUsraSrv = extrUsraSrv;
            _tokenService = tokenService;
        }

        [HttpGet("RGTR_USRA_V")]
        public IActionResult RGTR_USRA_V()
        {
            return View();
        }

        [HttpPost("RGTR_USRA_U")]
        public async Task<IActionResult> RGTR_USRA_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.CRET_USRA_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("INIT_USRA_U")]
        [Authorize]
        public async Task<IActionResult> INIT_USRA_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.INIT_USRA_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("LGIN_USRA_V")]
        public IActionResult LGIN_USRA_V()
        {
            return View();
        }

        [HttpGet("LGOT_USRA_V")]
        [Authorize]
        public async Task<IActionResult> LGOT_USRA_V()
        {
            var username = User.Identity?.Name;
            if (!string.IsNullOrEmpty(username))
            {
                var payload = JsonSerializer.Serialize(new
                {
                    lgottype = "001",
                    USER_APP_NAME = username
                });
                await _extrUsraSrv.LGOT_USRA_U(payload);
            }

            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("LGIN_USRA_V");
        }

        [HttpPost("LGIN_USRA_U")]
        public async Task<IActionResult> LGIN_USRA_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.LGIN_USRA_U(p_in);

            // 3. تبدیل خروجی دیتابیس به JsonDocument برای بررسی
            using var doc = JsonDocument.Parse(result);
            var root = doc.RootElement;

            // 4. بررسی کد پاسخ (0 یعنی موفق)
            var rspncode = root.GetProperty("rspncode").GetString();

            if (rspncode == "0")
            {
                // استخراج نام کاربری برای ساخت توکن
                var requestJson = JsonDocument.Parse(p_in);
                var username = requestJson.RootElement.GetProperty("USER_APP_NAME").GetString();

                // لاگین موفق - تولید توکن JWT
                var token = _tokenService.GenerateToken(username ?? throw new ArgumentNullException(nameof(username)));

                // تنظیم کوکی احراز هویت برای مرور نرمال صفحات
                var claims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, username),
                    new Claim(ClaimTypes.NameIdentifier, username)
                };
                var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

                var rememberMe = requestJson.RootElement.GetProperty("REMEMBER_ME").GetString();
                var cookieExpiry = rememberMe == "1"
                    ? DateTime.UtcNow.AddDays(7)
                    : DateTime.UtcNow.AddMinutes(60);

                await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme,
                    new ClaimsPrincipal(claimsIdentity),
                    new AuthenticationProperties
                    {
                        IsPersistent = rememberMe == "1",
                        ExpiresUtc = cookieExpiry
                    });

                // برگردوندن پاسخ موفق به همراه توکن
                return Ok(new LoginResponseDto
                {
                    Success = true,                    
                    Rspncode = root.GetProperty("rspncode").GetString() ?? "",
                    Rspndesc = root.GetProperty("rspndesc").GetString() ?? "",
                    
                    Username = username,
                    Token = token,
                    ExpiresAt = DateTime.Now.AddMinutes(60)
                });
            }

            // لاگین ناموفق
            return Unauthorized(new LoginResponseDto
            {
                Success = false,
                Rspndesc = "اطلاعات کاربری یا رمز عبور صحیح نمی‌باشد. لطفا دوباره تلاش کنید.",
                Rspncode = root.GetProperty("rspncode").GetString() ?? "",
                OracleErrorMessage = root.GetProperty("sqlerrm").GetString() ?? "",
            });
        }

        [HttpPost("LGOT_USRA_U")]
        [Authorize]
        public async Task<IActionResult> LGOT_USRA_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.LGOT_USRA_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CRET_USRA_U")]
        [Authorize]
        public async Task<IActionResult> CRET_USRA_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.CRET_USRA_U(p_in);
            return Content(result, "application/json");
        }

        [HttpDelete("REMV_USRA_U")]
        [Authorize]
        public async Task<IActionResult> REMV_USRA_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.REMV_USRA_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPut("UPDT_USRA_U")]
        [Authorize]
        public async Task<IActionResult> UPDT_USRA_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.UPDT_USRA_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("ACTV_USRA_U")]
        [Authorize]
        public async Task<IActionResult> ACTV_USRA_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.ACTV_USRA_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("DACT_USRA_U")]
        [Authorize]
        public async Task<IActionResult> DACT_USRA_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.DACT_USRA_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("UPDT_PSWD_U")]
        [Authorize]
        public async Task<IActionResult> UPDT_PSWD_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.UPDT_PSWD_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("UPDT_PINC_U")]
        [Authorize]
        public async Task<IActionResult> UPDT_PINC_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.UPDT_PINC_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("DUPL_USRA_U")]
        [Authorize]
        public async Task<IActionResult> DUPL_USRA_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.DUPL_USRA_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("CHCK_PRIV_U")]
        [Authorize]
        public async Task<IActionResult> CHCK_PRIV_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.CHCK_PRIV_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("ENBL_TOTP_U")]
        [Authorize]
        public async Task<IActionResult> ENBL_TOTP_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.ENBL_TOTP_U(p_in);
            return Content(result, "application/json");
        }

        [HttpPost("DSBL_TOTP_U")]
        [Authorize]
        public async Task<IActionResult> DSBL_TOTP_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.DSBL_TOTP_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("LIST_USRA_V")]
        [Authorize]
        public IActionResult LIST_USRA_V()
        {
            return View();
        }

        [HttpPost("LIST_USRA_U")]
        [Authorize]
        public async Task<IActionResult> LIST_USRA_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.LIST_USRA_U(p_in);
            return Content(result, "application/json");
        }

        [HttpGet("GETP_USRA_V")]
        [Authorize]
        public IActionResult GETP_USRA_V(string? userName = null)
        {
            ViewData["EditUserName"] = userName;
            return View();
        }

        [HttpPost("GETP_USRA_U")]
        [Authorize]
        public async Task<IActionResult> GETP_USRA_U([FromBody] string p_in)
        {
            var result = await _extrUsraSrv.GETP_USRA_U(p_in);
            using var doc = JsonDocument.Parse(result);
            var root = doc.RootElement;
            var rspncode = root.GetProperty("rspncode").GetString();

            if (rspncode == "0")
            {
                return Ok(new
                {
                    success = true,
                    data = JsonDocument.Parse(result).RootElement
                });
            }

            return BadRequest(new
            {
                success = false,
                message = doc.RootElement.GetProperty("rspndesc").GetString()
            });
        }
    }
}