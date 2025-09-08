-- ui/widgets/mem.lua
-- RAM em círculo animado

local wibox = require("wibox")
local lain  = require("lain")

local arc = wibox.widget {
    max_value     = 100,
    value         = 0,
    thickness     = 12,
    start_angle   = math.pi * 1.5,
    bg            = "#222222",
    colors        = { "#41F300" },
    widget        = wibox.container.arcchart
}

local text = wibox.widget {
    markup = "RAM",
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
    forced_height = 100,
    forced_width  = 100,
    widget = wibox.container.margin
}

lain.widgets.mem({
    settings = function()
        local perc = mem_now.perc or 0
        arc.value = perc
        if perc < 60 then
            arc.colors = { "#41F300" }
        elseif perc < 85 then
            arc.colors = { "#E3E34E" }
        else
            arc.colors = { "#EB8F8F" }
        end
        text.markup = string.format("<span foreground='#DDDCFF'>%d%%</span>", perc)
    end
})

return widget
