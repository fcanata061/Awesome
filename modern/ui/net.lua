-- ui/widgets/net.lua
-- Widget de rede: círculos para download e upload

local wibox   = require("wibox")
local vicious = require("vicious")

-- Função para criar círculo de rede
local function create_net_circle(label, color, key)
    local arc = wibox.widget {
        max_value     = 100,
        value         = 0,
        thickness     = 8,
        start_angle   = math.pi * 1.5,
        rounded_edge  = true,
        bg            = "#222222",
        colors        = { color },
        widget        = wibox.container.arcchart
    }

    local text = wibox.widget {
        markup = label,
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
        forced_height = 70,
        forced_width  = 70,
        widget = wibox.container.margin
    }

    -- Atualiza com dados reais
    vicious.register(arc, vicious.widgets.net,
        function(_, args)
            local kb = tonumber(args[key]) or 0
            -- normaliza para 100 apenas como efeito visual
            arc.value = math.min(kb / 1024, 100)
            text.markup = string.format(
                "<span foreground='%s'>%.0fKb</span>",
                color, kb
            )
        end,
        2,
        "wlan0" -- Troque para sua interface (ex: eth0, enp3s0, wlan0)
    )

    return widget
end

-- Widget final: download + upload lado a lado
local net_widget = wibox.widget {
    create_net_circle("↓", "#41F300", "{wlan0 down_kb}"),
    create_net_circle("↑", "#E3E34E", "{wlan0 up_kb}"),
    spacing = 10,
    layout = wibox.layout.fixed.horizontal
}

return net_widget
