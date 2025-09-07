-- ui/widgets/battery.lua
-- Widget circular de bateria com cores dinâmicas

local wibox = require("wibox")
local lain  = require("lain")

local bat_arc = wibox.widget {
    max_value     = 100,
    value         = 0,
    thickness     = 10,
    start_angle   = math.pi * 1.5,
    rounded_edge  = true,
    bg            = "#222222",
    colors        = { "#41F300" }, -- inicial (verde)
    widget        = wibox.container.arcchart
}

local bat_text = wibox.widget {
    markup = "<span foreground='#AAAAAA'>BAT</span>",
    align  = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local battery_widget = wibox.widget {
    {
        bat_arc,
        { bat_text, widget = wibox.container.place },
        layout = wibox.layout.stack
    },
    forced_height = 80,
    forced_width  = 80,
    widget = wibox.container.margin
}

-- Atualização com lain
lain.widgets.bat({
    settings = function()
        local perc = tonumber(bat_now.perc) or 0
        local status = bat_now.status or "N/A"

        bat_arc.value = perc

        -- Define cor conforme a porcentagem
        if perc > 70 then
            bat_arc.colors = { "#41F300" } -- verde
        elseif perc > 30 then
            bat_arc.colors = { "#E3E34E" } -- amarelo
        else
            bat_arc.colors = { "#EB8F8F" } -- vermelho
        end

        -- Texto central
        if status == "Charging" then
            bat_text.markup = string.format("<span foreground='#DDDCFF'>⚡ %d%%</span>", perc)
        else
            bat_text.markup = string.format("<span foreground='#DDDCFF'>%d%%</span>", perc)
        end
    end
})

return battery_widget
