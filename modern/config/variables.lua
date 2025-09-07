-- config/variables.lua
-- Variáveis globais do AwesomeWM

local awful = require("awful")

local vars = {}

-- Programas padrão
vars.terminal   = "alacritty"
vars.editor     = os.getenv("EDITOR") or "nvim"
vars.editor_cmd = vars.terminal .. " -e " .. vars.editor
vars.browser    = "firefox"
vars.files      = "thunar"

-- Modkeys
vars.modkey = "Mod4"   -- Super/Win
vars.altkey = "Mod1"   -- Alt

-- Layouts disponíveis
vars.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.max,
    awful.layout.suit.floating,
}

-- Tags (workspaces)
vars.tags = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

return vars
