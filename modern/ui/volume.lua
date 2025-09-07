-- ui/widgets/volume.lua
-- Widget circular de volume (pulseaudio)

local wibox = require("wibox")
local lain  = require("lain")

local vol_arc = wibox.widget {
    max_value     = 100,
    value         = 0,
    thickness     = 10,
    start_angle   = math.pi * 1.5,
    rounded_edge  = true,
    bg            = "#222222",
    colors        = { "#7A5ADA" }, -- roxo
    widget        = wibox.container.arcchart
}

local vol_text = wibox.widget {
    markup = "<span foreground='#AAAAAA'>VOL</span>",
    align  = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local volume_widget = wibox.widget {
    {
        vol_arc,
        { vol_text, widget = wibox.container.place },
        layout = wibox.layout.stack
    },
    forced_height = 80,
    forced_width  = 80,
    widget = wibox.container.margin
}

-- Atualização com lain (alsa/pulseaudio)
lain.widgets.alsa({
    settings = function()
        local level = tonumber(volume_now.level) or 0
        local status = volume_now.status or "on"

        vol_arc.value = level

        if status == "off" or level == 0 then
            vol_text.markup = "<span foreground='#EB8F8F'>🔇</span>"
        else
            vol_text.markup = string.format("<span foreground='#DDDCFF'>🔊 %d%%</span>", level)
        end
    end
})

return volume_widget
