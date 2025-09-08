-- config/variables.lua
-- Variáveis globais do Awesome

local awful = require("awful")

-- Terminal e editor padrão
terminal = "alacritty"
editor   = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Tecla Mod
modkey = "Mod4"

-- Layouts disponíveis
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.floating,
    awful.layout.suit.max,
    awful.layout.suit.magnifier,
    awful.layout.suit.spiral,
  }
