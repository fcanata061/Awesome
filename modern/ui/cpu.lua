-- ui/widgets/cpu.lua
-- CPU widgets circulares, um por núcleo

local wibox    = require("wibox")
local vicious  = require("vicious")

-- Ajuste de acordo com seu processador
local num_cores = 8

-- Cria um círculo de CPU para um core específico
local function create_cpu_circle(core)
    local arc = wibox.widget {
        max_value     = 100,
        value         = 0,
        thickness     = 10,
        start_angle   = math.pi * 1.5,
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

    -- Atualiza com dados reais da CPU
    vicious.register(arc, vicious.widgets.cpu,
        function(_, args)
            local usage = args[core + 1] or 0
            arc.value = usage
            text.markup = string.format(
                "<span foreground='#DDDCFF'>%d%%</span>",
                usage
            )
        end,
        2
    )

    return widget
end

-- Gera uma grade de círculos (4 por linha)
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

-- Exporta widget final
local cpu_widget = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    table.unpack(rows)
}

return cpu_widget
