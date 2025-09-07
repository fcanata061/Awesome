local awful = require("awful")
local ruled = require("ruled")
local beautiful = require("beautiful")
local vars = require("config.variables")

ruled.client.connect_signal("request::rules", function()

    -- Regras padrão
    ruled.client.append_rule {
        id = "global",
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus        = awful.client.focus.filter,
            raise        = true,
            keys         = clientkeys,
            buttons      = clientbuttons,
            screen       = awful.screen.preferred,
            placement    = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }

    -- Exemplo: MPlayer sempre flutuante
    ruled.client.append_rule {
        rule = { class = "MPlayer" },
        properties = { floating = true }
    }

end)

return true
