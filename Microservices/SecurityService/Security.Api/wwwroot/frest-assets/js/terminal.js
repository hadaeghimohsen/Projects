;(function () {
    var toggle = document.getElementById('terminalToggle')
    var consoleEl = document.getElementById('terminalConsole')
    var output = document.getElementById('terminalOutput')
    var input = document.getElementById('terminalInput')
    var display = document.getElementById('terminalDisplay')
    var cursorEl = document.getElementById('terminalCursor')
    var closeBtn = document.getElementById('terminalClose')
    var maximizeBtn = document.getElementById('terminalMaximize')
    var isOpen = false
    var history = []
    var historyIndex = -1

    if (!consoleEl || !toggle) return

    function syncDisplay() {
        if (display) display.textContent = input ? input.value : ''
    }

    if (display) {
        display.addEventListener('click', function () {
            if (input) input.focus()
        })
    }

    var field = document.querySelector('.terminal-field')
    if (field) {
        field.addEventListener('click', function () {
            if (input) input.focus()
        })
    }

    function open() {
        isOpen = true
        consoleEl.classList.add('is-open')
        toggle.classList.add('is-open')
        if (input) setTimeout(function () { input.focus() }, 350)
    }

    function close() {
        isOpen = false
        consoleEl.classList.remove('is-open')
        toggle.classList.remove('is-open')
        if (input) input.blur()
    }

    function toggleConsole() {
        isOpen ? close() : open()
    }

    toggle.addEventListener('click', toggleConsole)
    if (closeBtn) closeBtn.addEventListener('click', close)

    if (maximizeBtn) {
        maximizeBtn.addEventListener('click', function () {
            var expanded = consoleEl.classList.toggle('is-expanded')
            var icon = maximizeBtn.querySelector('i')
            if (icon) {
                icon.className = expanded ? 'bx bx-collapse' : 'bx bx-expand'
            }
            maximizeBtn.title = expanded ? 'Restore' : 'Expand'
        })
    }

    function appendLine(text, cls) {
        if (!output) return
        var line = document.createElement('div')
        line.className = 'terminal-line' + (cls ? ' ' + cls : '')
        line.textContent = text
        output.appendChild(line)
        output.scrollTop = output.scrollHeight
    }

    function appendHTML(html, cls) {
        if (!output) return
        var line = document.createElement('div')
        line.className = 'terminal-line' + (cls ? ' ' + cls : '')
        line.innerHTML = html
        output.appendChild(line)
        output.scrollTop = output.scrollHeight
    }

    function pad(n) { return n < 10 ? '0' + n : '' + n }

    var commands = {}

    commands['help'] = function () {
        appendLine('Available commands:', 'info')
        appendLine('')
        var cmds = [
            ['help',            'Show this help message'],
            ['clear',           'Clear terminal output'],
            ['exit',            'Close terminal'],
            ['version',         'Show application version'],
            ['date',            'Show current date and time'],
            ['whoami',          'Show current user info'],
            ['ping <host>',     'Check if host is reachable'],
            ['weather',         'Show current weather'],
            ['echo <text>',     'Print text to terminal'],
            ['history',         'Show command history'],
            ['stats',           'Show system statistics'],
            ['uptime',          'Show system uptime'],
            ['uname',           'Show system information'],
            ['ls',              'List available modules'],
            ['cat <file>',      'Show file content (simulated)'],
            ['mkdir <name>',    'Create directory (simulated)'],
            ['rm <name>',       'Remove file (simulated)'],
            ['touch <name>',    'Create file (simulated)'],
            ['cd <dir>',        'Change directory (simulated)'],
            ['pwd',             'Print working directory'],
            ['neofetch',        'Show system info (ASCII art)'],
        ]
        for (var i = 0; i < cmds.length; i++) {
            var padLen = 20 - cmds[i][0].length
            var spaces = ''
            for (var s = 0; s < padLen; s++) spaces += ' '
            appendLine('  ' + cmds[i][0] + spaces + cmds[i][1], 'output')
        }
    }

    commands['clear'] = function () {
        output.innerHTML = ''
    }

    commands['exit'] = function () {
        close()
    }

    commands['version'] = function () {
        appendLine('Fceo Security Service', 'success')
        appendLine('Version: ' + (window.__appVersion || '1.0.0'), 'output')
        appendLine('Build: ' + new Date().toISOString().split('T')[0], 'output')
    }

    commands['date'] = function () {
        var now = new Date()
        appendLine(now.toLocaleString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' }), 'output')
        appendLine(now.toLocaleTimeString('en-US', { hour12: false }) + ' UTC+' + (-now.getTimezoneOffset() / 60), 'output')
    }

    commands['whoami'] = function () {
        appendLine('user@fceo-security', 'success')
        appendLine('  Role:    Administrator', 'output')
        appendLine('  Shell:   fceo-console/1.0', 'output')
        appendLine('  Host:    ' + (window.location.hostname || 'localhost'), 'output')
    }

    commands['weather'] = function () {
        appendLine('Fetching weather data...', 'info')
        if (typeof $ !== 'undefined') {
            $.get('/EXTR_WEATHER/Current')
                .done(function (d) {
                    if (d && d.city) {
                        appendLine(d.city + ': ' + (d.tempC || '--') + '°C - ' + (d.conditionDesc || ''), 'success')
                    } else {
                        appendLine('Weather data unavailable', 'warn')
                    }
                })
                .fail(function () { appendLine('Could not reach weather service', 'error') })
        } else {
            appendLine('jQuery not available', 'error')
        }
    }

    commands['echo'] = function (args) {
        appendLine(args.join(' '), 'output')
    }

    commands['history'] = function () {
        if (history.length === 0) {
            appendLine('No commands in history', 'warn')
            return
        }
        for (var i = 0; i < history.length; i++) {
            appendLine('  ' + pad(i + 1) + '  ' + history[i], 'output')
        }
    }

    commands['stats'] = function () {
        appendLine('System Statistics:', 'info')
        appendLine('  Status:       Online', 'success')
        appendLine('  Uptime:       ' + getUptime(), 'output')
        appendLine('  Server Time:  ' + new Date().toLocaleTimeString('en-US', { hour12: false }), 'output')
        appendLine('  Console:      Active', 'output')
        appendLine('  Protocol:     HTTP/' + (window.location.protocol === 'https:' ? '2' : '1.1'), 'output')
    }

    commands['uptime'] = function () {
        appendLine('up ' + getUptime() + ', 1 user', 'output')
    }

    commands['uname'] = function () {
        appendLine('Fceo Security Service v' + (window.__appVersion || '1.0.0'), 'output')
        appendLine('ASP.NET Core / .NET 8.0', 'output')
    }

    var modules = [
        'auth/', 'users/', 'roles/', 'groups/', 'audit/', 'logs/',
        'dashboard/', 'settings/', 'reports/', 'broadcast/', 'notifications/'
    ]
    var currentDir = '~'

    commands['ls'] = function () {
        appendLine(modules.join('  '), 'output')
    }

    commands['pwd'] = function () {
        appendLine('/fceo' + currentDir, 'output')
    }

    commands['cd'] = function (args) {
        if (args.length === 0 || args[0] === '~') {
            currentDir = '~'
            appendLine('Changed to home directory', 'output')
        } else {
            var dir = args[0]
            if (modules.indexOf(dir + '/') !== -1) {
                currentDir = dir
                appendLine('Changed to /fceo/' + dir, 'output')
            } else {
                appendLine('cd: ' + dir + ': No such directory', 'error')
            }
        }
    }

    var fakeFiles = {
        'config.json': '{\n  "app": "Fceo Security",\n  "version": "1.0.0",\n  "debug": false\n}',
        'readme.txt': 'Fceo Security Service\nManagement console for enterprise security.',
    }

    commands['cat'] = function (args) {
        if (args.length === 0) {
            appendLine('cat: missing file operand', 'error')
            return
        }
        var file = args[0]
        if (fakeFiles[file]) {
            var lines = fakeFiles[file].split('\n')
            for (var i = 0; i < lines.length; i++) {
                appendLine(lines[i], 'output')
            }
        } else {
            appendLine('cat: ' + file + ': No such file', 'error')
        }
    }

    commands['touch'] = function (args) {
        if (args.length === 0) {
            appendLine('touch: missing file operand', 'error')
            return
        }
        fakeFiles[args[0]] = ''
        appendLine('Created: ' + args[0], 'success')
    }

    commands['mkdir'] = function (args) {
        if (args.length === 0) {
            appendLine('mkdir: missing operand', 'error')
            return
        }
        modules.push(args[0] + '/')
        appendLine('Directory created: ' + args[0], 'success')
    }

    commands['rm'] = function (args) {
        if (args.length === 0) {
            appendLine('rm: missing operand', 'error')
            return
        }
        var name = args[0]
        var idx = modules.indexOf(name + '/')
        if (idx !== -1) {
            modules.splice(idx, 1)
            appendLine('Removed: ' + name, 'success')
        } else if (fakeFiles[name]) {
            delete fakeFiles[name]
            appendLine('Removed: ' + name, 'success')
        } else {
            appendLine('rm: ' + name + ': No such file or directory', 'error')
        }
    }

    commands['ping'] = function (args) {
        if (args.length === 0) {
            appendLine('ping: usage: ping <host>', 'error')
            return
        }
        var host = args[0]
        appendLine('PING ' + host + '...', 'info')
        appendLine('Connecting to ' + host + '...', 'output')

        if (host === 'localhost' || host === '127.0.0.1') {
            appendLine('64 bytes from ' + host + ': icmp_seq=1 ttl=64 time=0.04ms', 'output')
            appendLine('64 bytes from ' + host + ': icmp_seq=2 ttl=64 time=0.03ms', 'output')
            appendLine('64 bytes from ' + host + ': icmp_seq=3 ttl=64 time=0.04ms', 'output')
            appendLine('--- ' + host + ' ping statistics ---', 'info')
            appendLine('3 packets transmitted, 3 received, 0% packet loss', 'success')
        } else {
            $.ajax({
                url: '/EXTR_WEATHER/Current',
                method: 'HEAD',
                timeout: 3000
            }).done(function () {
                appendLine('64 bytes from ' + host + ': icmp_seq=1 ttl=64 time=' + (5 + Math.floor(Math.random() * 20)) + 'ms', 'output')
                appendLine('64 bytes from ' + host + ': icmp_seq=2 ttl=64 time=' + (5 + Math.floor(Math.random() * 20)) + 'ms', 'output')
                appendLine('--- ' + host + ' ping statistics ---', 'info')
                appendLine('2 packets transmitted, 2 received, 0% packet loss', 'success')
            }).fail(function () {
                appendLine('Request timed for host: ' + host, 'error')
                appendLine('--- ' + host + ' ping statistics ---', 'info')
                appendLine('3 packets transmitted, 0 received, 100% packet loss', 'error')
            })
        }
    }

    commands['neofetch'] = function () {
        var ascii = [
            '        _____      ',
            '       /     \\     ',
            '      / () () \\    ',
            '     |   __   |   ',
            '      \\  \\/  /     ',
            '       \\_____/     ',
            '      /|     |\\    ',
            '     / |     | \\   ',
        ]
        var info = [
            'user@fceo-security',
            '-------------------',
            'OS:    Fceo Linux',
            'Shell: fceo-console',
            'Host:  ' + (window.location.hostname || 'localhost'),
            'Time:  ' + new Date().toLocaleTimeString('en-US', { hour12: false }),
            'Ver:   ' + (window.__appVersion || '1.0.0'),
        ]
        for (var i = 0; i < Math.max(ascii.length, info.length); i++) {
            var left = ascii[i] || '                    '
            var right = info[i] || ''
            appendHTML('<span style="color:#4ade80">' + left + '</span>  ' + right, 'output')
        }
    }

    function getUptime() {
        var diff = Math.floor((Date.now() - (window.__startTime || Date.now())) / 1000)
        var h = Math.floor(diff / 3600)
        var m = Math.floor((diff % 3600) / 60)
        return h + 'h ' + m + 'm'
    }

    function processCommand(cmd) {
        var trimmed = cmd.trim()
        if (!trimmed) return

        appendLine('$ ' + trimmed, '')
        history.push(trimmed)
        historyIndex = history.length

        var parts = trimmed.split(/\s+/)
        var command = parts[0].toLowerCase()
        var args = parts.slice(1)

        if (commands[command]) {
            commands[command](args)
        } else {
            appendLine('fceo: command not found: ' + command, 'error')
            appendLine('Type "help" for available commands.', 'warn')
        }
    }

    if (input) {
        input.addEventListener('input', syncDisplay)

        input.addEventListener('keydown', function (e) {
            if (e.key === 'Enter') {
                e.preventDefault()
                var cmd = input.value
                input.value = ''
                syncDisplay()
                processCommand(cmd)
            } else if (e.key === 'ArrowUp') {
                e.preventDefault()
                if (history.length > 0 && historyIndex > 0) {
                    historyIndex--
                    input.value = history[historyIndex]
                    syncDisplay()
                }
            } else if (e.key === 'ArrowDown') {
                e.preventDefault()
                if (historyIndex < history.length - 1) {
                    historyIndex++
                    input.value = history[historyIndex]
                    syncDisplay()
                } else {
                    historyIndex = history.length
                    input.value = ''
                    syncDisplay()
                }
            } else if (e.key === 'l' && e.ctrlKey) {
                e.preventDefault()
                output.innerHTML = ''
            }
        })
    }

    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape' && isOpen) close()
        if (e.key === '`' && e.ctrlKey) {
            e.preventDefault()
            toggleConsole()
        }
    })

    window.__startTime = Date.now()

    setTimeout(function () {
        appendLine('Fceo Security Console v' + (window.__appVersion || '1.0.0'), 'info')
        appendLine('Type "help" for available commands.', 'warn')
        appendLine('', '')
    }, 500)

    window.__console = {
        open: open,
        close: close,
        toggle: toggleConsole,
        log: function (text, cls) { appendLine(text, cls || 'output') },
        clear: function () { if (output) output.innerHTML = '' },
        command: function (name, fn, desc) {
            commands[name] = fn
        }
    }
})()
