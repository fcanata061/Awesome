-- ui/widgets/net.lua
-- Reimplementação do blingbling NET em Awesome moderno

local wibox   = require("wibox")
local vicious = require("vicious")

---------------------------------------------------
-- Texto com status de rede (similar ao blingbling.net)
---------------------------------------------------
local net_text = wibox.widget {
    markup = "<span foreground='#DDDCFF'>NET</span>",
    align  = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

vicious.register(net_text, vicious.widgets.net,
    function(_, args)
        local down = tonumber(args["{wlan0 down_kb}"]) or 0
        local up   = tonumber(args["{wlan0 up_kb}"]) or 0
        return string.format(
            "<span foreground='#41F300'>↓ %dkB</span> <span foreground='#E3E34E'>↑ %dkB</span>",
            down, up
        )
    end,
    2
)

---------------------------------------------------
-- Gráfico de download (linha)
---------------------------------------------------
local netdown_graph = wibox.widget {
    max_value        = 1000, -- escala em kb/s
    background_color = "#222222",
    color            = "#41F300", -- verde
    step_width       = 2,
    step_spacing     = 1,
    widget           = wibox.widget.graph,
}

netdown_graph:set_width(120)
netdown_graph:set_height(40)

vicious.register(netdown_graph, vicious.widgets.net,
    function(_, args)
        return tonumber(args["{wlan0 down_kb}"]) or 0
    end,
    2
)

---------------------------------------------------
-- Gráfico de upload (linha)
---------------------------------------------------
local netup_graph = wibox.widget {
    max_value        = 1000, -- escala em kb/s
    background_color = "#222222",
    color            = "#E3E34E", -- amarelo
    step_width       = 2,
    step_spacing     = 1,
    widget           = wibox.widget.graph,
}

netup_graph:set_width(120)
netup_graph:set_height(40)

vicious.register(netup_graph, vicious.widgets.net,
    function(_, args)
        return tonumber(args["{wlan0 up_kb}"]) or 0
    end,
    2
)

---------------------------------------------------
-- Layout final
---------------------------------------------------
local net_widget = wibox.widget {
    net_text,
    netdown_graph,
    netup_graph,
    spacing = 6,
    layout  = wibox.layout.fixed.vertical
}

return net_widget
