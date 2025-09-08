-- ui/widgets/cpu.lua
-- CPU total + núcleos em círculos

local wibox   = require("wibox")
local vicious = require("vicious")

local num_cores = 4 -- ajuste conforme seu processador

-- CPU total
local cpu_total = wibox.widget {
    max_value     = 100,
    value         = 0,
    thickness     = 12,
    start_angle   = math.pi * 1.5,
    bg            = "#222222",
    colors        = { "#7A5ADA" },
    widget        = wibox.container.arcchart
}

local cpu_text = wibox.widget {
    markup = "<span foreground='#DDDCFF'>CPU</span>",
    align  = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local cpu_widget = wibox.widget {
    {
        cpu_total,
        { cpu_text, widget = wibox.container.place },
        layout = wibox.layout.stack
    },
    forced_height = 100,
    forced_width  = 100,
    widget = wibox.container.margin
}

vicious.register(cpu_total, vicious.widgets.cpu,
    function(_, args)
        local usage = args[1]
        cpu_total.value = usage
        cpu_text.markup = string.format("<span foreground='#DDDCFF'>%d%%</span>", usage)
    end,
    2
)

-- CPU cores
local cores_layout = wibox.widget {
    spacing = 8,
    layout  = wibox.layout.fixed.horizontal
}

for i = 1, num_cores do
    local arc = wibox.widget {
        max_value     = 100,
        value         = 0,
        thickness     = 8,
        start_angle   = math.pi * 1.5,
        bg            = "#222222",
        colors        = { "#41F300" },
        widget        = wibox.container.arcchart
    }

    vicious.register(arc, vicious.widgets.cpu,
        function(_, args)
            local usage = args[i + 1] or 0
            arc.value = usage
            if usage < 40 then
                arc.colors = { "#41F300" }
            elseif usage < 75 then
                arc.colors = { "#E3E34E" }
            else
                arc.colors = { "#EB8F8F" }
            end
        end,
        2
    )

    cores_layout:add(arc)
end

return wibox.widget {
    cpu_widget,
    cores_layout,
    spacing = 10,
    layout  = wibox.layout.fixed.vertical
}
