using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Net.Http;
using System.Text.Json;
using System.Threading.Tasks;

namespace Security.Api.Controllers
{
    [AllowAnonymous]
    public class EXTR_WEATHER_CTRL : Controller
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly string _city;

        public EXTR_WEATHER_CTRL(IHttpClientFactory httpClientFactory, IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _city = configuration.GetSection("WeatherSettings")["City"] ?? "Shiraz";
        }

        [HttpGet]
        public async Task<IActionResult> Current()
        {
            try
            {
                var client = _httpClientFactory.CreateClient();
                client.Timeout = System.TimeSpan.FromSeconds(5);
                var response = await client.GetStringAsync("https://wttr.in/" + _city + "?format=j1&lang=fa");
                using var doc = JsonDocument.Parse(response);
                var current = doc.RootElement.GetProperty("current_condition")[0];

                return Json(new
                {
                    tempC = current.GetProperty("temp_C").GetString(),
                    conditionCode = int.Parse(current.GetProperty("weatherCode").GetString() ?? "800"),
                    conditionDesc = current.GetProperty("lang_fa").GetProperty("value").GetString(),
                    isDay = current.GetProperty("isday").GetString() == "yes",
                    city = _city
                });
            }
            catch
            {
                var h = System.DateTime.Now.Hour;
                var isDay = h >= 6 && h < 19;
                return Json(new
                {
                    tempC = "",
                    conditionCode = isDay ? 800 : 800,
                    conditionDesc = isDay ? "صاف" : "شب",
                    isDay = isDay,
                    city = _city
                });
            }
        }
    }
}
