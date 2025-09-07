local wibox = require("wibox")
local lain  = require("lain")

local mem_arc = wibox.widget {
    max_value     = 100,
    thickness     = 10,
    start_angle   = math.pi * 1.5,
    rounded_edge  = true,
    bg            = "#222222",
    colors        = { "#41F300" },
    widget        = wibox.container.arcchart
}

local mem_text = wibox.widget {
    markup = "RAM",
    align  = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local mem_widget = wibox.widget {
    {
        mem_arc,
        { mem_text, widget = wibox.container.place },
        layout = wibox.layout.stack
    },
    forced_height = 80,
    forced_width  = 80,
    widget = wibox.container.margin
}

lain.widgets.mem({
    settings = function()
        mem_arc.value = mem_now.perc
        mem_text.markup = string.format(
            "<span foreground='#DDDCFF'>%d%%</span>",
            mem_now.perc
        )
    end
})

return mem_widget
