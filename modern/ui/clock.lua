-- ui/widgets/clock.lua
-- Relógio circular com hora no centro

local wibox = require("wibox")

-- Arcchart decorativo do relógio
local clock_arc = wibox.widget {
    max_value     = 60,
    value         = 0,
    thickness     = 6,
    start_angle   = math.pi * 1.5,
    rounded_edge  = true,
    bg            = "#222222",
    colors        = { "#7A5ADA" }, -- roxo
    widget        = wibox.container.arcchart
}

-- Texto com hora e data
local clock_text = wibox.widget.textclock(
    "<span foreground='#DDDCFF'>%H:%M</span>\n<span foreground='#AAAAAA'>%a %d %b</span>",
    60 -- atualizar a cada minuto
)

clock_text.align  = "center"
clock_text.valign = "center"

-- Widget final (círculo + texto no meio)
local clock_widget = wibox.widget {
    {
        clock_arc,
        { clock_text, widget = wibox.container.place },
        layout = wibox.layout.stack
    },
    forced_height = 100,
    forced_width  = 100,
    widget = wibox.container.margin
}

-- Atualiza o arco com os segundos (efeito animado)
local gears = require("gears")
gears.timer {
    timeout   = 1,
    autostart = true,
    call_now  = true,
    callback  = function()
        local sec = tonumber(os.date("%S"))
        clock_arc.value = sec
    end
}

return clock_widget
