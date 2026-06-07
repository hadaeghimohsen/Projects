(function () {
    var clockEl = document.getElementById('dtClock');
    var dateEl = document.getElementById('dtDate');
    var weatherEl = document.getElementById('dtWeather');
    var overlay = document.getElementById('weatherOverlay');
    var city = weatherEl ? weatherEl.getAttribute('data-city') || 'Tehran' : 'Tehran';
    var weatherCache = null;

    function pad(n) { return n < 10 ? '0' + n : '' + n; }

    function persianDateStr() {
        try {
            var d = new Date();
            return d.toLocaleDateString('fa-IR', {
                year: 'numeric', month: 'long', day: 'numeric', weekday: 'long'
            });
        } catch (e) {
            return '';
        }
    }

    function updateClock() {
        if (!clockEl) return;
        var d = new Date();
        clockEl.textContent = pad(d.getHours()) + ':' + pad(d.getMinutes()) + ':' + pad(d.getSeconds());
    }

    function updateDate() {
        if (!dateEl) return;
        dateEl.textContent = persianDateStr();
    }

    function setWeather(data) {
        if (!weatherEl) return;
        if (!data) {
            weatherEl.innerHTML = '';
            return;
        }
        var code = data.conditionCode || 800;
        var desc = data.conditionDesc || '';
        var temp = data.tempC != null ? data.tempC : '';
        var isDay = data.isDay !== false;

        var icon = getWeatherIcon(code, isDay);
        var html = '<span class="wi-city">' + city + '</span>';
        html += '<span class="wi-icon">' + icon + '</span>';
        if (temp !== '') html += '<span class="wi-temp">' + temp + '°</span>';
        weatherEl.innerHTML = html;
        weatherEl.title = desc + ' - ' + city;

        applyWeatherEffect(code, isDay, temp);
    }

    function getWeatherIcon(code, isDay) {
        if (code >= 200 && code < 300) return '⛈';
        if (code >= 300 && code < 400) return '🌦';
        if (code >= 500 && code < 600) return '🌧';
        if (code >= 600 && code < 700) return '🌨';
        if (code >= 700 && code < 800) return '🌫';
        if (code === 800) return isDay ? '☀️' : '🌙';
        if (code === 801) return '🌤';
        if (code === 802) return '⛅';
        if (code >= 803) return '☁️';
        return isDay ? '☀️' : '🌙';
    }

    function getWeatherType(code, isDay) {
        if (!isDay && (code === 800 || code === -1)) return 'night';
        if (code >= 200 && code < 600) return 'rainy';
        if (code >= 600 && code < 700) return 'snowy';
        if (code === 800 || code === -1) return 'sunny';
        if (code >= 801 && code <= 802) return 'cloudy';
        if (code >= 803) return 'cloudy';
        return '';
    }

    function applyWeatherEffect(code, isDay) {
        if (!overlay) return;
        var type = getWeatherType(code, isDay);
        overlay.className = 'weather-overlay';
        if (type) overlay.classList.add('weather-' + type);
        if (type === 'rainy') createRaindrops(60);
        else if (type === 'night') createStars(30);
        else if (type === 'sunny') createSunRays(6);
        else overlay.innerHTML = '';
    }

    function createRaindrops(count) {
        var existing = overlay.querySelectorAll('.raindrop');
        if (existing.length > 0) return;
        overlay.innerHTML = '';
        for (var i = 0; i < count; i++) {
            var drop = document.createElement('div');
            drop.className = 'raindrop';
            drop.style.left = Math.random() * 100 + '%';
            drop.style.height = (8 + Math.random() * 18) + 'px';
            drop.style.animationDuration = (0.5 + Math.random() * 0.6) + 's';
            drop.style.animationDelay = Math.random() * 2 + 's';
            overlay.appendChild(drop);
        }
    }

    function createStars(count) {
        var existing = overlay.querySelectorAll('.star');
        if (existing.length > 0) return;
        overlay.innerHTML = '';
        for (var i = 0; i < count; i++) {
            var star = document.createElement('div');
            star.className = 'star';
            star.style.left = Math.random() * 100 + '%';
            star.style.top = Math.random() * 60 + '%';
            star.style.animationDelay = Math.random() * 3 + 's';
            star.style.animationDuration = (1.5 + Math.random() * 2) + 's';
            overlay.appendChild(star);
        }
    }

    function createSunRays(count) {
        var existing = overlay.querySelectorAll('.sun-ray');
        if (existing.length > 0) return;
        overlay.innerHTML = '';
        var cx = 80, cy = 10;
        for (var i = 0; i < count; i++) {
            var ray = document.createElement('div');
            ray.className = 'sun-ray';
            var angle = (i / count) * 360;
            var rad = angle * Math.PI / 180;
            var r = 60;
            ray.style.left = (cx + Math.cos(rad) * r) + '%';
            ray.style.top = (cy + Math.sin(rad) * r * 0.5) + '%';
            ray.style.transform = 'rotate(' + angle + 'deg)';
            ray.style.animationDelay = (i * 0.4) + 's';
            overlay.appendChild(ray);
        }
    }

    function getDefaultWeather() {
        var h = new Date().getHours();
        var isDay = h >= 6 && h < 19;
        return {
            conditionCode: isDay ? 800 : 800,
            conditionDesc: isDay ? 'صاف' : 'شب',
            tempC: '',
            isDay: isDay
        };
    }

    function fetchWeather() {
        $.get('/EXTR_WEATHER/Current')
            .done(function (data) {
                if (data && data.conditionCode != null) {
                    weatherCache = data;
                    setWeather(data);
                } else {
                    setWeather(getDefaultWeather());
                }
            })
            .fail(function () {
                setWeather(getDefaultWeather());
            });
    }

    function init() {
        updateClock();
        updateDate();
        setInterval(updateClock, 1000);
        setInterval(updateDate, 60000);
        fetchWeather();
        setInterval(fetchWeather, 600000);
    }

    if (clockEl || weatherEl) {
        if (typeof $ !== 'undefined') {
            $(document).ready(init);
        } else {
            init();
        }
    }
})();
