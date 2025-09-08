-- ui/widgets/clock.lua
-- Relógio circular animado

local wibox = require("wibox")
local gears = require("gears")

local arc = wibox.widget {
    max_value     = 60,
    value         = 0,
    thickness     = 8,
    start_angle   = math.pi * 1.5,
    bg            = "#222222",
    colors        = { "#7A5ADA" },
    widget        = wibox.container.arcchart
}

local text = wibox.widget.textclock(
    "<span foreground='#DDDCFF'>%H:%M</span>\n<span foreground='#AAAAAA'>%a %d %b</span>",
    60
)

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

gears.timer {
    timeout   = 1,
    autostart = true,
    call_now  = true,
    callback  = function()
        arc.value = tonumber(os.date("%S"))
    end
}

return widget
