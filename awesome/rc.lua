-- rc.lua - Configuração principal do AwesomeWM modernizado

-- Bibliotecas principais
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local lain = require("lain")
local ruled = require("ruled")

-- Inicialização do tema
local home = os.getenv("HOME")
local confdir = home .. "/.config/awesome"
beautiful.init(confdir .. "/themes/msjche/theme.lua")

-- Carregar módulos organizados
local vars     = require("config.variables")
local bindings = require("config.bindings")
local rules    = require("config.rules")
local signals  = require("config.signals")
local topbar   = require("ui.topbar")
local sidebar  = require("ui.sidebar")

-- Aplicar atalhos globais
root.keys(bindings.globalkeys)
root.buttons(bindings.globalbuttons)

-- Criar barras para cada tela
awful.screen.connect_for_each_screen(function(s)
    topbar(s)
    sidebar(s)
end)

-- Executar autostart
awful.spawn.with_shell(confdir .. "/autostart.sh")
