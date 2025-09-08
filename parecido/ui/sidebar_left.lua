-- ui/sidebar_left.lua
local awful  = require("awful")
local wibox  = require("wibox")

local cpu    = require("ui.widgets.cpu")
local mem    = require("ui.widgets.mem")
local net    = require("ui.widgets.net")
local disks  = require("ui.widgets.disks")

return function(s)
    s.myleftdock = awful.wibar {
        position = "left",
        screen   = s,
        width    = 180,
        bg       = "#121212ee",
        fg       = "#DDDCFF",
        type     = "dock"
    }

    -- empilhar tudo em coluna
    local cpu_col = wibox.widget {
        layout  = wibox.layout.fixed.vertical,
        spacing = 6
    }
    for _, c in ipairs(cpu) do cpu_col:add(c) end

    s.myleftdock:setup {
        layout  = wibox.layout.fixed.vertical,
        spacing = 10,
        cpu_col,
        mem,
        net,
        disks,
    }
end
