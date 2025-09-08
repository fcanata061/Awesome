-- ui/widgets/volume.lua
-- Reimplementação do blingbling.volume em Awesome moderno

local wibox = require("wibox")
local lain  = require("lain")

---------------------------------------------------
-- Barra de volume
---------------------------------------------------
local vol_bar = wibox.widget {
    max_value        = 100,
    value            = 0,
    forced_height    = 20,
    forced_width     = 160,
    color            = "#7A5ADA", -- roxo
    background_color = "#222222",
    border_width     = 1,
    border_color     = "#444444",
    widget           = wibox.widget.progressbar
}

---------------------------------------------------
-- Texto com status de volume
---------------------------------------------------
local vol_text = wibox.widget {
    markup = "<span foreground='#AAAAAA'>VOL</span>",
    align  = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

---------------------------------------------------
-- Atualizar com Lain (usando ALSA/PulseAudio)
---------------------------------------------------
lain.widgets.alsa({
    settings = function()
        local level = tonumber(volume_now.level) or 0
        local status = volume_now.status or "on"

        vol_bar.value = level

        if status == "off" or level == 0 then
            vol_bar.color = "#EB8F8F" -- vermelho se mudo
            vol_text.markup = "<span foreground='#EB8F8F'>MUTE</span>"
        else
            vol_bar.color = "#7A5ADA" -- roxo se ativo
            vol_text.markup = string.format("<span foreground='#DDDCFF'>VOL %d%%</span>", level)
        end
    end
})

---------------------------------------------------
-- Layout final
---------------------------------------------------
local volume_widget = wibox.widget {
    vol_text,
    vol_bar,
    spacing = 6,
    layout  = wibox.layout.fixed.vertical
}

return volume_widget
