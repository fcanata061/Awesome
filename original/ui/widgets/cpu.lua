-- ui/widgets/cpu.lua
-- Reimplementação do blingbling CPU em Awesome moderno

local wibox   = require("wibox")
local vicious = require("vicious")

local cpu_widget = {}

---------------------------------------------------
-- CPU graph (linha animada do uso total)
---------------------------------------------------
local cpu_graph = wibox.widget {
    max_value        = 100,
    background_color = "#222222",
    color            = "#7A5ADA", -- roxo
    step_width       = 2,
    step_spacing     = 1,
    widget           = wibox.widget.graph,
}

cpu_graph:set_width(120)
cpu_graph:set_height(40)

-- Atualizar com uso de CPU total
vicious.register(cpu_graph, vicious.widgets.cpu,
    function(_, args)
        return args[1] -- uso total em %
    end,
    2
)

---------------------------------------------------
-- CPU cores (círculos individuais)
---------------------------------------------------
local num_cores = 4 -- ajuste conforme seu processador

local function create_core_circle(core)
    local arc = wibox.widget {
        max_value     = 100,
        value         = 0,
        thickness     = 6,
        start_angle   = math.pi * 1.5,
        bg            = "#222222",
        colors        = { "#41F300" },
        widget        = wibox.container.arcchart
    }

    -- Atualizar com vicious
    vicious.register(arc, vicious.widgets.cpu,
        function(_, args)
            local usage = args[core + 1] or 0
            arc.value = usage
            if usage < 40 then
                arc.colors = { "#41F300" } -- verde
            elseif usage < 75 then
                arc.colors = { "#E3E34E" } -- amarelo
            else
                arc.colors = { "#EB8F8F" } -- vermelho
            end
        end,
        2
    )

    return arc
end

local cores_layout = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = 8
}
for i = 1, num_cores do
    cores_layout:add(create_core_circle(i))
end

---------------------------------------------------
-- CPU label (texto)
---------------------------------------------------
local cpu_label = wibox.widget {
    markup = "<span foreground='#DDDCFF'>CPU</span>",
    align  = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

---------------------------------------------------
-- Montagem final (stack dos widgets)
---------------------------------------------------
cpu_widget = wibox.widget {
    {
        cpu_label,
        {
            cpu_graph,
            cores_layout,
            spacing = 6,
            layout  = wibox.layout.fixed.vertical
        },
        layout = wibox.layout.fixed.vertical
    },
    widget = wibox.container.margin,
    margins = 6
}

return cpu_widget
