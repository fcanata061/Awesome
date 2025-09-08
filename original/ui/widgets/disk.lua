-- ui/widgets/disk.lua
-- Reimplementação dos blingbling DISK graphs em Awesome moderno

local wibox   = require("wibox")
local vicious = require("vicious")

---------------------------------------------------
-- Função para criar barra de disco
---------------------------------------------------
local function create_disk_bar(mountpoint, label)
    local bar = wibox.widget {
        max_value        = 100,
        value            = 0,
        forced_height    = 20,
        forced_width     = 160,
        color            = "#7A5ADA",  -- roxo
        background_color = "#222222",
        border_width     = 1,
        border_color     = "#444444",
        widget           = wibox.widget.progressbar
    }

    local txt = wibox.widget {
        markup = string.format("<span foreground='#DDDCFF'>%s</span>", label),
        align  = "left",
        valign = "center",
        widget = wibox.widget.textbox
    }

    -- Layout final: texto + barra
    local widget = wibox.widget {
        {
            txt,
            bar,
            spacing = 6,
            layout  = wibox.layout.fixed.vertical
        },
        widget  = wibox.container.margin,
        margins = 6
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

---------------------------------------------------
-- Montagem dos discos (ajuste para os seus pontos de montagem)
---------------------------------------------------
local disk_widget = wibox.widget {
    create_disk_bar("/",   "root"),
    create_disk_bar("/boot", "boot"),
    create_disk_bar("/home", "home"),
    spacing = 4,
    layout  = wibox.layout.fixed.vertical
}

return disk_widget
