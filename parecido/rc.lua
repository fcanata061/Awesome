-- rc.lua
pcall(require, "luarocks.loader")

local gears     = require("gears")
local awful     = require("awful")
local beautiful = require("beautiful")

-- Tema
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/all-circles/theme.lua")

-- Config
require("config.variables")
require("config.bindings")
require("config.rules")
require("config.signals")

-- UI
local topbar       = require("ui.topbar")
local sidebar_left = require("ui.sidebar_left")

awful.screen.connect_for_each_screen(function(s)
    topbar(s)
    sidebar_left(s)
end)

-- Autostart
awful.spawn.with_shell(gears.filesystem.get_configuration_dir() .. "autostart.sh")
