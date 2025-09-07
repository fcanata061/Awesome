-- ui/widgets/mem.lua
-- Widget de memória em círculo único

local wibox = require("wibox")
local lain  = require("lain")

-- Arcchart da RAM
local mem_arc = wibox.widget {
    max_value     = 100,
    value         = 0,
    thickness     = 10,
    start_angle   = math.pi * 1.5,
    rounded_edge  = true,
    bg            = "#222222",
    colors        = { "#41F300" }, -- verde padrão
    widget        = wibox.container.arcchart
}

-- Texto dentro do círculo
local mem_text = wibox.widget {
    markup = "<span foreground='#AAAAAA'>RAM</span>",
    align  = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

-- Combinação círculo + texto
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

-- Atualiza com o uso real da memória
lain.widgets.mem({
    settings = function()
        local perc = mem_now.perc or 0
        mem_arc.value = perc
        mem_text.markup = string.format(
            "<span foreground='#DDDCFF'>%d%%</span>",
            perc
        )
    end
})

return mem_widget
