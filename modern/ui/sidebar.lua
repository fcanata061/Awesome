-- ui/sidebar.lua
-- Barra lateral esquerda (painel de monitoramento)

local awful = require("awful")
local wibox = require("wibox")
local wi    = require("ui.widgets")

return function(s)

    -- Barra lateral (wibar)
    s.myverticalwibox = awful.wibar {
        position = "left",
        screen   = s,
        width    = 120,
        bg       = "#121212aa",
        fg       = "#DDDCFF"
    }

    s.myverticalwibox:setup {
        layout = wibox.layout.align.vertical,

        { -- Topo
            layout = wibox.layout.fixed.vertical,
            -- (você pode colocar logo/launcher aqui depois)
        },

        { -- Meio (widgets principais)
            layout = wibox.layout.fixed.vertical,
            wi.cpu,
            wi.mem,
            wi.disk,
            wi.net,
            wi.battery,
        },

        { -- Base (reservado, pode adicionar mais depois)
            layout = wibox.layout.fixed.vertical,
        },
    }
end
