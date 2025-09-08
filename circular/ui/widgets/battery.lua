-- ui/widgets/battery.lua
-- Bateria em círculo

local wibox = require("wibox")
local lain  = require("lain")

local arc = wibox.widget {
    max_value     = 100,
    value         = 0,
    thickness     = 10,
    start_angle   = math.pi * 1.5,
    bg            = "#222222",
    colors        = { "#41F300" },
    widget        = wibox.container.arcchart
}

local text = wibox.widget {
    markup = "BAT",
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

lain.widgets.bat({
    settings = function()
        local perc = tonumber(bat_now.perc) or 0
        local status = bat_now.status or "N/A"

        arc.value = perc
        if perc > 70 then
            arc.colors = { "#41F300" }
        elseif perc > 30 then
            arc.colors = { "#E3E34E" }
        else
            arc.colors = { "#EB8F8F" }
        end

        if status == "Charging" then
            text.markup = string.format("⚡ %d%%", perc)
        else
            text.markup = string.format("%d%%", perc)
        end
    end
})

return widget
