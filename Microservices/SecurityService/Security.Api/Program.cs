using Security.Domain.Interfaces;
using Security.Infrastructure.Repositories;
using Security.Application.Services;
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.IdentityModel.Tokens;
using Security.Api.Configs;

var builder = WebApplication.CreateBuilder(args);

// 1. افزودن سرویس‌ها
builder.Services.AddControllers();
builder.Services.AddControllersWithViews();
builder.Services.AddRazorPages();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// 2. Connection String
var connectionString = builder.Configuration.GetConnectionString("OracleDb")
    ?? throw new InvalidOperationException("Connection string 'OracleDb' not found.");

// 3. Dependency Injection
builder.Services.AddScoped<IEXTR_USRA_SRVC>(provider =>
    new EXTR_USRA_SRVC(new EXTR_USRA_PKG(connectionString))
);

builder.Services.AddScoped<IEXTR_ROLE_SRVC>(provider =>
    new EXTR_ROLE_SRVC(new EXTR_ROLE_PKG(connectionString))
);

builder.Services.AddScoped<IEXTR_ADYM_SRVC>(provider =>
    new EXTR_ADYM_SRVC(new EXTR_ADYM_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_ASDM_SRVC>(provider =>
    new EXTR_ASDM_SRVC(new EXTR_ASDM_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_BOXP_SRVC>(provider =>
    new EXTR_BOXP_SRVC(new EXTR_BOXP_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_BRDC_SRVC>(provider =>
    new EXTR_BRDC_SRVC(new EXTR_BRDC_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_CSTR_SRVC>(provider =>
    new EXTR_CSTR_SRVC(new EXTR_CSTR_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_DSRC_SRVC>(provider =>
    new EXTR_DSRC_SRVC(new EXTR_DSRC_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_GPUA_SRVC>(provider =>
    new EXTR_GPUA_SRVC(new EXTR_GPUA_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_GROP_SRVC>(provider =>
    new EXTR_GROP_SRVC(new EXTR_GROP_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_HINF_SRVC>(provider =>
    new EXTR_HINF_SRVC(new EXTR_HINF_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_MSGB_SRVC>(provider =>
    new EXTR_MSGB_SRVC(new EXTR_MSGB_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_NEWS_SRVC>(provider =>
    new EXTR_NEWS_SRVC(new EXTR_NEWS_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_PGAT_SRVC>(provider =>
    new EXTR_PGAT_SRVC(new EXTR_PGAT_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_PRVL_SRVC>(provider =>
    new EXTR_PRVL_SRVC(new EXTR_PRVL_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_PTRN_SRVC>(provider =>
    new EXTR_PTRN_SRVC(new EXTR_PTRN_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_RLSR_SRVC>(provider =>
    new EXTR_RLSR_SRVC(new EXTR_RLSR_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_ROLP_SRVC>(provider =>
    new EXTR_ROLP_SRVC(new EXTR_ROLP_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_SRRH_SRVC>(provider =>
    new EXTR_SRRH_SRVC(new EXTR_SRRH_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_SYS_SRVC>(provider =>
    new EXTR_SYS_SRVC(new EXTR_SYS_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_SYSR_SRVC>(provider =>
    new EXTR_SYSR_SRVC(new EXTR_SYSR_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_UAPR_SRVC>(provider =>
    new EXTR_UAPR_SRVC(new EXTR_UAPR_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_UARL_SRVC>(provider =>
    new EXTR_UARL_SRVC(new EXTR_UARL_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_UAIH_SRVC>(provider =>
    new EXTR_UAIH_SRVC(new EXTR_UAIH_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_UAIN_SRVC>(provider =>
    new EXTR_UAIN_SRVC(new EXTR_UAIN_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_UIMG_SRVC>(provider =>
    new EXTR_UIMG_SRVC(new EXTR_UIMG_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_UNOT_SRVC>(provider =>
    new EXTR_UNOT_SRVC(new EXTR_UNOT_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_URTK_SRVC>(provider =>
    new EXTR_URTK_SRVC(new EXTR_URTK_PKG(connectionString))
);
builder.Services.AddScoped<IEXTR_USON_SRVC>(provider =>
    new EXTR_USON_SRVC(new EXTR_USON_PKG(connectionString))
);

builder.Services.AddScoped<Security.Application.Interfaces.ITokenService,
    Security.Infrastructure.Services.TokenService>();

// 4. تنظیمات JWT
var jwtSettings = builder.Configuration.GetSection("JwtSettings").Get<JwtSettings>()
    ?? throw new InvalidOperationException("JwtSettings not found.");
var key = Encoding.ASCII.GetBytes(jwtSettings.SecretKey);

builder.Services.AddAuthentication(options =>
{
    options.DefaultScheme = "JWT_OR_COOKIE";
    options.DefaultChallengeScheme = "JWT_OR_COOKIE";
})
.AddPolicyScheme("JWT_OR_COOKIE", "JWT_OR_COOKIE", options =>
{
    options.ForwardDefaultSelector = context =>
    {
        if (context.Request.Path.StartsWithSegments("/api"))
            return JwtBearerDefaults.AuthenticationScheme;
        return CookieAuthenticationDefaults.AuthenticationScheme;
    };
})
.AddJwtBearer(options =>
{
    options.RequireHttpsMetadata = false;
    options.SaveToken = true;
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(key),
        ValidateIssuer = false,
        ValidateAudience = false
    };
})
.AddCookie(options =>
{
    options.Cookie.HttpOnly = true;
    options.Cookie.SameSite = SameSiteMode.Lax;
    options.ExpireTimeSpan = TimeSpan.FromMinutes(60);
    options.SlidingExpiration = true;
});

var app = builder.Build();

// 5. Middleware Pipeline (ترتیب درست)
//if (app.Environment.IsDevelopment())
//{
//    app.UseSwagger();
//    app.UseSwaggerUI();
//}

app.UseHttpsRedirection();
app.UseStaticFiles();        // اول فایل‌های استاتیک

app.UseRouting();            // بعد Routing

app.UseAuthentication();     // بعد احراز هویت
app.UseAuthorization();      // بعد مجوزها (فقط یک بار)

// 6. Endpointها
app.MapControllers();
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=EXTR_USRA_CTRL}/{action=LGIN_USRA_V}");
app.MapRazorPages();

// اضافه کن - ریدایرکت ریشه
app.MapGet("/", context =>
{
    context.Response.Redirect("EXTR_USRA_CTRL/LGIN_USRA_V");
    return Task.CompletedTask;
});

app.Run();