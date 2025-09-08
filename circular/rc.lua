-- rc.lua - Configuração AwesomeWM estilo All-Circles

-- Libs principais
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")

-- Diretórios
local home    = os.getenv("HOME")
local confdir = home .. "/.config/awesome/all-circles"

-- Tema
beautiful.init(confdir .. "/themes/all-circles/theme.lua")

-- Config modular
local vars     = require("config.variables")
local bindings = require("config.bindings")
local rules    = require("config.rules")
local signals  = require("config.signals")

-- UI
local topbar   = require("ui.topbar")
local sidebar  = require("ui.sidebar")

-- Widgets circulares
local wi       = require("ui.widgets")

-- Keybindings
root.keys(bindings.globalkeys)
root.buttons(bindings.globalbuttons)

-- Criar barras por tela
awful.screen.connect_for_each_screen(function(s)
    topbar(s)
    sidebar(s)
end)

-- Autostart
awful.spawn.with_shell(confdir .. "/autostart.sh")
