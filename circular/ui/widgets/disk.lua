-- ui/widgets/disk.lua
-- Discos em círculos

local wibox   = require("wibox")
local vicious = require("vicious")

local function create_disk_circle(mount, label)
    local arc = wibox.widget {
        max_value     = 100,
        value         = 0,
        thickness     = 10,
        start_angle   = math.pi * 1.5,
        bg            = "#222222",
        colors        = { "#7A5ADA" },
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

    vicious.register(arc, vicious.widgets.fs,
        function(_, args)
            local perc = args["{" .. mount .. " used_p}"] or 0
            arc.value = perc
            if perc < 70 then
                arc.colors = { "#41F300" }
            elseif perc < 90 then
                arc.colors = { "#E3E34E" }
            else
                arc.colors = { "#EB8F8F" }
            end
            text.markup = string.format("<span foreground='#DDDCFF'>%s\n%d%%</span>", label, perc)
        end,
        20
    )

    return widget
end

return wibox.widget {
    create_disk_circle("/", "root"),
    create_disk_circle("/boot", "boot"),
    create_disk_circle("/home", "home"),
    spacing = 8,
    layout  = wibox.layout.fixed.horizontal
}
