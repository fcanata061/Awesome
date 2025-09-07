local wibox   = require("wibox")
local vicious = require("vicious")

local function create_net_circle(label, color, index)
    local arc = wibox.widget {
        max_value     = 100,
        thickness     = 8,
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
        forced_height = 70,
        forced_width  = 70,
        widget = wibox.container.margin
    }

    vicious.register(arc, vicious.widgets.net,
        function(_, args)
            arc.value = math.min(args[index] / 1024, 100) -- normaliza
            text.markup = string.format("<span foreground='%s'>%.0fKb</span>", color, args[index] / 1024)
        end,
        2,
        "wlan0" -- troca pra sua interface
    )

    return widget
end

local net_widget = wibox.widget {
    create_net_circle("↓", "#41F300", "${wlan0 down_kb}"),
    create_net_circle("↑", "#E3E34E", "${wlan0 up_kb}"),
    layout = wibox.layout.fixed.horizontal
}

return net_widget
