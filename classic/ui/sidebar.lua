-- ui/sidebar.lua
-- Barra lateral esquerda

local awful = require("awful")
local wibox = require("wibox")
local wi    = require("ui.widgets")

return function(s)

    -- Criar a wibar lateral
    s.myverticalwibox = awful.wibar { position = "left", screen = s, width = 95 }

    s.myverticalwibox:setup {
        layout = wibox.layout.align.vertical,
        { -- Topo
            layout = wibox.layout.fixed.vertical,
            wi.mylauncher,
        },
        nil, -- Meio vazio (pode colocar algo depois)
        { -- Base
            layout = wibox.layout.fixed.vertical,
            wi.cpuwidget,
            wi.freq1,
            wi.tempwidget,
            wi.memwidget,
            wi.fshome,
            wi.wifiwidget,
            wi.uptimewidget,
        },
    }
end
