-- ui/widgets/volume.lua
-- Volume em círculo

local wibox = require("wibox")
local lain  = require("lain")

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
    markup = "VOL",
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

lain.widgets.alsa({
    settings = function()
        local level = tonumber(volume_now.level) or 0
        local status = volume_now.status or "on"

        arc.value = level
        if status == "off" or level == 0 then
            arc.colors = { "#EB8F8F" }
            text.markup = "🔇"
        else
            arc.colors = { "#7A5ADA" }
            text.markup = string.format("🔊 %d%%", level)
        end
    end
})

return widget
