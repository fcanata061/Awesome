-- ui/widgets/net.lua
-- Rede em dois círculos (download/upload)

local wibox   = require("wibox")
local vicious = require("vicious")

local function create_circle(label, color, key)
    local arc = wibox.widget {
        max_value     = 100,
        value         = 0,
        thickness     = 10,
        start_angle   = math.pi * 1.5,
        bg            = "#222222",
        colors        = { color },
        widget        = wibox.container.arcchart
    }

    local text = wibox.widget {
        markup = label,
        align  = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    local widget = wibox.widget {
        {
            arc,
            { text, widget = wibox.container.place },
            layout = wibox.layout.stack
        },
        forced_height = 80,
        forced_width  = 80,
        widget = wibox.container.margin
    }

    vicious.register(arc, vicious.widgets.net,
        function(_, args)
            local kb = tonumber(args[key]) or 0
            arc.value = math.min(kb / 100, 100)
            text.markup = string.format("<span foreground='%s'>%s\n%.0fKb</span>", color, label, kb)
        end,
        2,
        "wlan0" -- ajuste para sua interface
    )

    return widget
end

return wibox.widget {
    create_circle("↓", "#41F300", "{wlan0 down_kb}"),
    create_circle("↑", "#E3E34E", "{wlan0 up_kb}"),
    spacing = 10,
    layout  = wibox.layout.fixed.horizontal
}
