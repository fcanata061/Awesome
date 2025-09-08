-- ui/sidebar.lua
-- Sidebar estilo blingbling retrô atualizado para Awesome moderno

local awful = require("awful")
local wibox = require("wibox")
local wi    = require("ui.widgets")

return function(s)

    -- Barra lateral (à direita)
    s.myverticalwibox = awful.wibar {
        position = "right",
        screen   = s,
        width    = 200,
        bg       = "#121212ee",
        fg       = "#DDDCFF"
    }

    s.myverticalwibox:setup {
        layout = wibox.layout.fixed.vertical,
        spacing = 8,

        -- CPU total + núcleos
        wi.cpu,

        -- Memória RAM
        wi.mem,

        -- Discos (root, boot, home)
        wi.disk,

        -- Rede (status + gráficos down/up)
        wi.net,

        -- Volume (nível + mute)
        wi.volume,
    }
end
