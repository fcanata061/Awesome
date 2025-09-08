-- config/rules.lua
-- Regras de janelas (retrô)

local awful = require("awful")
local ruled = require("ruled")
local beautiful = require("beautiful")

ruled.client.connect_signal("request::rules", function()

    -- Regras padrão
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus        = awful.client.focus.filter,
            raise        = true,
            screen       = awful.screen.preferred,
            placement    = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }

    -- Exemplo: mpv sempre flutuante
    ruled.client.append_rule {
        rule       = { class = "mpv" },
        properties = { floating = true }
    }

end)

return true
