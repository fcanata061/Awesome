-- Variáveis globais
local awful = require("awful")

local vars = {}

vars.terminal  = "urxvt"
vars.editor    = os.getenv("EDITOR") or "vim"
vars.editor_cmd = vars.terminal .. " -e " .. vars.editor
vars.browser   = "qutebrowser"
vars.mail      = vars.terminal .. " -e mutt"
vars.musicplr  = vars.terminal .. " -g l30x34-320+16 -e ncmpcpp"

vars.modkey = "Mod4"
vars.altkey = "Mod1"

-- Layouts
vars.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.max,
    awful.layout.suit.spiral,
    awful.layout.suit.floating
}

-- Tags
vars.tags = { "WEB", "POR", "NEW", "IRC", "MUS", "PIR", "MOV", "GAM", "MIS" }

return vars
