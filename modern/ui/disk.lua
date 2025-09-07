-- ui/widgets/disk.lua
-- Widget de uso de disco (barras horizontais por partição)

local wibox   = require("wibox")
local vicious = require("vicious")

-- Função para criar uma barra de disco para uma partição
local function create_disk_bar(mountpoint, label)
    local bar = wibox.widget {
        max_value     = 100,
        value         = 0,
        forced_height = 20,
        forced_width  = 160,
        color         = "#7A5ADA",
        background_color = "#222222",
        border_width  = 1,
        border_color  = "#444444",
        widget        = wibox.widget.progressbar
    }

    local txt = wibox.widget {
        markup = string.format("<span foreground='#AAAAAA'>%s</span>", label),
        align  = "left",
        valign = "center",
        widget = wibox.widget.textbox
    }

    -- Layout final: label + barra
    local widget = wibox.widget {
        {
            txt,
            {
                bar,
                widget = wibox.container.margin,
                left = 10,
                right = 10,
            },
            layout = wibox.layout.align.horizontal
        },
        widget = wibox.container.margin,
        top = 2, bottom = 2
    }

    -- Atualizar com vicious
    vicious.register(bar, vicious.widgets.fs,
        function(_, args)
            local perc = args["{" .. mountpoint .. " used_p}"] or 0
            bar.value = perc
            if perc < 70 then
                bar.color = "#41F300" -- verde
            elseif perc < 90 then
                bar.color = "#E3E34E" -- amarelo
            else
                bar.color = "#EB8F8F" -- vermelho
            end
        end,
        20
    )

    return widget
end

-- Defina suas partições aqui
local disk_widget = wibox.widget {
    create_disk_bar("/", "root"),
    create_disk_bar("/home", "home"),
    spacing = 4,
    layout = wibox.layout.fixed.vertical
}

return disk_widget
