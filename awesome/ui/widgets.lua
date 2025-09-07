-- ui/widgets.lua
-- Widgets personalizados do usuário (migrado de wi.lua)

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
local naughty = require("naughty")
local lain = require("lain")

-- Diretórios
local home     = os.getenv("HOME")
local confdir  = home .. "/.config/awesome"
local themes   = confdir .. "/themes"
local active_theme = themes .. "/msjche"

-- Cores e estilo
local markup      = lain.util.markup
local blue        = "#7A5ADA"
local gray        = "#858585"
local red         = "#EB8F8F"
local green       = "#41F300"
local yellow      = "#E3E34E"
local background  = "#00000000"
local border      = "#4A4A4A50"

-- Tabela final de exportação
local widgets = {}

--------------------------------------------------------------------------------
-- Menu principal
--------------------------------------------------------------------------------
local myawesomemenu = {
   { "manual", "urxvt -e man awesome" },
   { "edit config", "urxvt -e nvim " .. awesome.conffile },
   { "reload", awesome.restart },
   { "quit", awesome.quit },
   { "reboot", "reboot" },
   { "shutdown", "poweroff" }
}

local mymainmenu = awful.menu({ items = {
    { "awesome", myawesomemenu },
    { "terminal", "urxvt" },
    { "browser", "qutebrowser" },
    { "editor", "kate" },
}})

widgets.mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

--------------------------------------------------------------------------------
-- Relógio + calendário
--------------------------------------------------------------------------------
widgets.mytextclock = wibox.widget.textclock(markup(gray, "%a %d %b ") .. markup(blue, "%H:%M "))
lain.widgets.calendar.attach(widgets.mytextclock)

--------------------------------------------------------------------------------
-- MPD
--------------------------------------------------------------------------------
widgets.mpdicon = wibox.widget.imagebox(beautiful.widget_mpd)
widgets.mpdwidget = lain.widgets.mpd({
    settings = function()
        if mpd_now.state == "play" then
            widget:set_markup(markup(blue, mpd_now.artist) .. markup(gray, " ") .. markup(beautiful.fg_focus, mpd_now.title))
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup(gray, "paused"))
        else
            widget:set_markup("")
        end
    end
})

--------------------------------------------------------------------------------
-- Memória
--------------------------------------------------------------------------------
widgets.memicon = wibox.widget.imagebox(beautiful.widget_mem)
widgets.memwidget = lain.widgets.mem({
    settings = function()
        widget:set_markup(markup(blue, mem_now.used .. "MB"))
    end
})

--------------------------------------------------------------------------------
-- CPU (uso e frequência)
--------------------------------------------------------------------------------
widgets.cpuicon = wibox.widget.imagebox(beautiful.widget_cpu)
widgets.cpuwidget = lain.widgets.cpu({
    settings = function()
        widget:set_markup(markup(blue, cpu_now.usage .. "%"))
    end
})

widgets.freq1 = wibox.widget.textbox()
vicious.register(widgets.freq1, vicious.widgets.cpufreq,
    markup(gray, "Freq: ") .. markup(blue, "$2GHz"), 3, "cpu0")

--------------------------------------------------------------------------------
-- Temperatura
--------------------------------------------------------------------------------
widgets.tempwidget = wibox.widget.textbox()
vicious.register(widgets.tempwidget, vicious.widgets.thermal,
    markup(gray, "Temp: ") .. markup(blue, "$1°C"), 5, { "coretemp.0/hwmon/hwmon0/", "core" })

--------------------------------------------------------------------------------
-- Disco (exemplo: /home)
--------------------------------------------------------------------------------
widgets.fshome = lain.widgets.fs({
    partition = "/home",
    settings = function()
        if fs_now.used >= 75 then
            widget:set_markup(markup(red, "Hdd " .. fs_now.used .. "%"))
        else
            widget:set_markup("")
        end
    end
})

--------------------------------------------------------------------------------
-- Volume (pulseaudio)
--------------------------------------------------------------------------------
widgets.volicon = wibox.widget.imagebox(beautiful.widget_vol)
widgets.volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            widget:set_markup(markup(red, "MUTE"))
        else
            widget:set_markup(markup(blue, volume_now.level .. "%"))
        end
    end
})

--------------------------------------------------------------------------------
-- Bateria
--------------------------------------------------------------------------------
widgets.baticon = wibox.widget.imagebox()
widgets.batwidget = lain.widgets.bat({
    settings = function()
        widget:set_markup(markup(blue, bat_now.perc .. "%"))
    end
})

--------------------------------------------------------------------------------
-- Rede (wifi)
--------------------------------------------------------------------------------
widgets.wifiicon = wibox.widget.imagebox()
widgets.wifiwidget = lain.widgets.net({
    settings = function()
        widget:set_markup(markup(blue, net_now.received .. " ↓↑ " .. net_now.sent))
    end
})

--------------------------------------------------------------------------------
-- Uptime
--------------------------------------------------------------------------------
widgets.uptimewidget = lain.widgets.uptime({
    settings = function()
        widget:set_markup(markup(blue, uptime_now.days .. "d " .. uptime_now.hours .. "h"))
    end
})

--------------------------------------------------------------------------------
-- Exportar todos os widgets
--------------------------------------------------------------------------------
return widgets
