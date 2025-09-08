-- ui/widgets/net.lua
local vicious = require("vicious")
local wibox   = require("wibox")
local circle  = require("ui.widgets.lib.fancy_circle")

local IFACE = "wlan0" -- troque conforme sua máquina

local net_down = circle({ diameter = 70, label = "↓", color = {0.35,0.75,1.0,0.95} })
local net_up   = circle({ diameter = 48, label = "↑", inner = true, scale = 0.70, color = {0.90,0.75,0.25,0.95} })

vicious.register(net_down, vicious.widgets.net, function(_, args)
    local kb = tonumber(args["{"..IFACE.." down_kb}"]) or 0
    net_down:set_value(math.min(kb/2000,1))
    net_down:set_text(kb.."kB/s")
end, 2, IFACE)

vicious.register(net_up, vicious.widgets.net, function(_, args)
    local kb = tonumber(args["{"..IFACE.." up_kb}"]) or 0
    net_up:set_value(math.min(kb/2000,1))
    net_up:set_text(kb.."kB/s")
end, 2, IFACE)

return wibox.widget {
    net_down,
    net_up,
    layout = wibox.layout.stack
}
