-- rc.lua - AwesomeWM retrô (widgets estilo blingbling atualizados)

-- Bibliotecas principais
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")

-- Diretórios
local home    = os.getenv("HOME")
local confdir = home .. "/.config/awesome"

-- Tema
beautiful.init(confdir .. "/themes/retro/theme.lua")

-- Configurações modulares
local vars     = require("config.variables")
local bindings = require("config.bindings")
local rules    = require("config.rules")
local signals  = require("config.signals")

-- UI
local topbar   = require("ui.topbar")
local sidebar  = require("ui.sidebar")

-- Widgets retrô (blingbling reimplementados)
local wi       = require("ui.widgets")

-- Atalhos globais
root.keys(bindings.globalkeys)
root.buttons(bindings.globalbuttons)

-- Criar barras em cada tela
awful.screen.connect_for_each_screen(function(s)
    topbar(s)   -- Barra superior minimalista
    sidebar(s)  -- Sidebar com widgets retrô
end)

-- Autostart
awful.spawn.with_shell(confdir .. "/autostart.sh")
