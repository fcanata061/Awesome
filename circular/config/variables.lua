local awful = require("awful")

local vars = {}

vars.terminal   = "xterm"
vars.editor     = os.getenv("EDITOR") or "nano"
vars.editor_cmd = vars.terminal .. " -e " .. vars.editor
vars.browser    = "firefox"
vars.files      = "thunar"

vars.modkey = "Mod4"
vars.altkey = "Mod1"

vars.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating,
}

vars.tags = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

return vars
