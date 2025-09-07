local awful = require("awful")
local wibox = require("wibox")
local wi    = require("wi")

return function(s)
    s.myverticalwibox = awful.wibar({ position = "left", screen = s, width = 95 })

    s.myverticalwibox:setup {
        layout = wibox.layout.align.vertical,
        { -- Topo
            layout = wibox.layout.fixed.vertical,
            wi.mylauncher,
        },
        nil,
        { -- Base
            layout = wibox.layout.fixed.vertical,
            wi.cpu_graph,
            wi.netwidget,
            wi.mem_graph,
            wi.root_graph,
        },
    }
end
