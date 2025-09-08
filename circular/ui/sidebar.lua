-- ui/sidebar.lua
-- Sidebar com todos os widgets circulares animados

local awful = require("awful")
local wibox = require("wibox")
local wi    = require("ui.widgets")

return function(s)
    -- Barra lateral à direita
    s.myverticalwibox = awful.wibar {
        position = "right",
        screen   = s,
        width    = 220,
        bg       = "#121212ee",
        fg       = "#DDDCFF"
    }

    -- Layout da sidebar
    s.myverticalwibox:setup {
        layout  = wibox.layout.fixed.vertical,
        spacing = 12,

        wi.clock,    -- Relógio circular
        wi.cpu,      -- CPU total + cores
        wi.mem,      -- RAM
        wi.disk,     -- Discos root/boot/home
        wi.net,      -- Rede (↓/↑)
        wi.volume,   -- Volume
        wi.battery,  -- Bateria
    }
end
