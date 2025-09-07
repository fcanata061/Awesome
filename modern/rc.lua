-- rc.lua - AwesomeWM modern config
-- Estrutura modular: carrega configs, widgets e UI

-- Bibliotecas principais
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local lain = require("lain")
local ruled = require("ruled")

-- Diretórios
local home    = os.getenv("HOME")
local confdir = home .. "/.config/awesome/modern"

-- Tema
beautiful.init(confdir .. "/themes/modern/theme.lua")

-- Configurações modulares
local vars     = require("config.variables")
local bindings = require("config.bindings")
local rules    = require("config.rules")
local signals  = require("config.signals")

-- UI
local topbar   = require("ui.topbar")
local sidebar  = require("ui.sidebar")

-- Atalhos globais
root.keys(bindings.globalkeys)
root.buttons(bindings.globalbuttons)

-- Criar barras em cada tela
awful.screen.connect_for_each_screen(function(s)
    topbar(s)
    sidebar(s)
end)

-- Autostart
awful.spawn.with_shell(confdir .. "/autostart.sh")
