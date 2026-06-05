#pragma warning disable S101 // controller name follows database naming convention

using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Security.Application.Dtos;
using Security.Application.Interfaces;
using Security.Domain.Interfaces;
using System.Security.Claims;
using System.Text.Json;

namespace Security.Api.Controllers;

[Route("[controller]")]
public class EXTR_USRA_CTRL(IEXTR_USRA_SRVC extrUsraSrv, ITokenService tokenService) : Controller
{
    private const string JsonContentType = "application/json";
    private const string RspncodeKey = "rspncode";

    [HttpGet("RGTR_USRA_V")]
    public IActionResult RGTR_USRA_V() => View();

    [HttpPost("RGTR_USRA_U")]
    public async Task<IActionResult> RGTR_USRA_U([FromBody] string p_in)
    {
        using var p_inDoc = JsonDocument.Parse(p_in);
        var p_inRoot = p_inDoc.RootElement;
        var p_inUpper = JsonSerializer.Serialize(new
        {
            lgintype = p_inRoot.GetProperty("lgintype").GetString(),
            USER_APP_NAME = p_inRoot.GetProperty("USER_APP_NAME").GetString()?.ToUpperInvariant(),
            USER_APP_DESC = p_inRoot.GetProperty("USER_APP_DESC").GetString(),
            PHON_NUMB = p_inRoot.GetProperty("PHON_NUMB").GetString(),
            EMAL_ADRS = p_inRoot.GetProperty("EMAL_ADRS").GetString(),
            PASS_WORD = p_inRoot.GetProperty("PASS_WORD").GetString(),
            REMEMBER_ME = p_inRoot.GetProperty("REMEMBER_ME").GetString()
        });
        var result = await extrUsraSrv.CRET_USRA_U(p_inUpper);
        return Content(result, JsonContentType);
    }

    [HttpPost("INIT_USRA_U")]
    [Authorize]
    public async Task<IActionResult> INIT_USRA_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.INIT_USRA_U(p_in);
        return Content(result, JsonContentType);
    }

    [HttpGet("LGIN_USRA_V")]
    public IActionResult LGIN_USRA_V() => View();

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
            await extrUsraSrv.LGOT_USRA_U(payload);
        }

        await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
        return RedirectToAction("LGIN_USRA_V");
    }

    [HttpPost("LGIN_USRA_U")]
    public async Task<IActionResult> LGIN_USRA_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.LGIN_USRA_U(p_in);

        using var doc = JsonDocument.Parse(result);
        var root = doc.RootElement;

        var rspncode = root.GetProperty(RspncodeKey).GetString();

        if (rspncode == "0")
        {
            using var p_req = JsonDocument.Parse(p_in);
            var p_reqRoot = p_req.RootElement;
            var username = p_reqRoot.GetProperty("USER_APP_NAME").GetString()!;

            var token = tokenService.GenerateToken(username);

            List<Claim> claims =
            [
                new(ClaimTypes.Name, username),
                new(ClaimTypes.NameIdentifier, username)
            ];
            var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

            var rememberMe = p_reqRoot.GetProperty("REMEMBER_ME").GetString();
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

            return Ok(new LoginResponseDto
            {
                Success = true,
                Rspncode = root.GetProperty(RspncodeKey).GetString() ?? "",
                Rspndesc = root.GetProperty("rspndesc").GetString() ?? "",

                Username = username,
                Token = token,
                ExpiresAt = DateTime.Now.AddMinutes(60)
            });
        }

        return Unauthorized(new LoginResponseDto
        {
            Success = false,
            Rspndesc = "\u0627\u0637\u0644\u0627\u0639\u0627\u062A \u06A9\u0627\u0631\u0628\u0631\u06CC \u06CC\u0627 \u0631\u0645\u0632 \u0639\u0628\u0648\u0631 \u0635\u062D\u06CC\u062D \u0646\u0645\u06CC\u200C\u0628\u0627\u0634\u062F. \u0644\u0637\u0641\u0627 \u062F\u0648\u0628\u0627\u0631\u0647 \u062A\u0644\u0627\u0634 \u06A9\u0646\u06CC\u062F.",
            Rspncode = root.GetProperty(RspncodeKey).GetString() ?? "",
            OracleErrorMessage = root.GetProperty("sqlerrm").GetString() ?? "",
        });
    }

    [HttpPost("LGOT_USRA_U")]
    [Authorize]
    public async Task<IActionResult> LGOT_USRA_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.LGOT_USRA_U(p_in);
        return Content(result, JsonContentType);
    }

    [HttpPost("CRET_USRA_U")]
    [Authorize]
    public async Task<IActionResult> CRET_USRA_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.CRET_USRA_U(p_in);
        return Content(result, JsonContentType);
    }

    [HttpDelete("REMV_USRA_U")]
    [Authorize]
    public async Task<IActionResult> REMV_USRA_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.REMV_USRA_U(p_in);
        return Content(result, JsonContentType);
    }

    [HttpPut("UPDT_USRA_U")]
    [Authorize]
    public async Task<IActionResult> UPDT_USRA_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.UPDT_USRA_U(p_in);
        return Content(result, JsonContentType);
    }

    [HttpPost("ACTV_USRA_U")]
    [Authorize]
    public async Task<IActionResult> ACTV_USRA_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.ACTV_USRA_U(p_in);
        return Content(result, JsonContentType);
    }

    [HttpPost("DACT_USRA_U")]
    [Authorize]
    public async Task<IActionResult> DACT_USRA_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.DACT_USRA_U(p_in);
        return Content(result, JsonContentType);
    }

    [HttpPost("UPDT_PSWD_U")]
    [Authorize]
    public async Task<IActionResult> UPDT_PSWD_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.UPDT_PSWD_U(p_in);
        return Content(result, JsonContentType);
    }

    [HttpPost("UPDT_PINC_U")]
    [Authorize]
    public async Task<IActionResult> UPDT_PINC_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.UPDT_PINC_U(p_in);
        return Content(result, JsonContentType);
    }

    [HttpPost("DUPL_USRA_U")]
    [Authorize]
    public async Task<IActionResult> DUPL_USRA_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.DUPL_USRA_U(p_in);
        return Content(result, JsonContentType);
    }

    [HttpPost("CHCK_PRIV_U")]
    [Authorize]
    public async Task<IActionResult> CHCK_PRIV_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.CHCK_PRIV_U(p_in);
        return Content(result, JsonContentType);
    }

    [HttpPost("ENBL_TOTP_U")]
    [Authorize]
    public async Task<IActionResult> ENBL_TOTP_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.ENBL_TOTP_U(p_in);
        return Content(result, JsonContentType);
    }

    [HttpPost("DSBL_TOTP_U")]
    [Authorize]
    public async Task<IActionResult> DSBL_TOTP_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.DSBL_TOTP_U(p_in);
        return Content(result, JsonContentType);
    }

    [HttpGet("LIST_USRA_V")]
    [Authorize]
    public IActionResult LIST_USRA_V() => View();

    [HttpPost("LIST_USRA_U")]
    [Authorize]
    public async Task<IActionResult> LIST_USRA_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.LIST_USRA_U(p_in);
        return Content(result, JsonContentType) ;
    }

    [HttpGet("UPDT_USRA_V")]
    [Authorize]
    public IActionResult UPDT_USRA_V(string? userName = null)
    {
        ViewData["EditUserName"] = userName;
        return View();
    }

    [HttpPost("GETP_USRA_U")]
    [Authorize]
    public async Task<IActionResult> GETP_USRA_U([FromBody] string p_in)
    {
        var result = await extrUsraSrv.GETP_USRA_U(p_in);
        return Content(result, JsonContentType);
    }
}
