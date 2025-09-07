-- ui/widgets/cpu.lua
-- CPU circular widgets (um por core)

local wibox    = require("wibox")
local vicious  = require("vicious")
local gears    = require("gears")

-- Quantidade de núcleos (ajuste conforme seu CPU)
local num_cores = 8

-- Tabela para exportar
local cpu_widgets = {}

-- Função para criar um widget circular por core
local function create_cpu_circle(core)
    local arc = wibox.widget {
        max_value     = 100,
        value         = 0,
        thickness     = 10,
        start_angle   = math.pi * 1.5, -- começa no topo
        rounded_edge  = true,
        bg            = "#222222",
        colors        = { "#7A5ADA" }, -- roxo padrão
        widget        = wibox.container.arcchart
    }

    local text = wibox.widget {
        markup = "<span foreground='#AAAAAA'>CPU" .. core .. "</span>",
        align  = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    -- Colocar o texto dentro do círculo
    local widget = wibox.widget {
        {
            arc,
            {
                text,
                widget = wibox.container.place
            },
            layout = wibox.layout.stack
        },
        forced_height = 80,
        forced_width  = 80,
        widget = wibox.container.margin
    }

    -- Atualizar via vicious
    vicious.register(arc, vicious.widgets.cpu,
        function(_, args)
            arc.value = args[core + 1] -- $2 = core0, $3 = core1, etc.
            text.markup = string.format(
                "<span foreground='#DDDCFF'>%d%%</span>",
                args[core + 1]
            )
        end,
        2
    )

    return widget
end

-- Criar um círculo para cada núcleo
local rows = {}
local row = {}

for i = 1, num_cores do
    table.insert(row, create_cpu_circle(i - 1))
    if i % 4 == 0 then
        table.insert(rows, wibox.layout.fixed.horizontal(row))
        row = {}
    end
end
if #row > 0 then
    table.insert(rows, wibox.layout.fixed.horizontal(row))
end

cpu_widgets.grid = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    table.unpack(rows)
}

return cpu_widgets
