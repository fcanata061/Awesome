-- ui/widgets/disks.lua
local vicious = require("vicious")
local wibox   = require("wibox")
local circle  = require("ui.widgets.lib.fancy_circle")

local function disk_circle(mount, label)
    local d = circle({ diameter = 62, label = label })
    vicious.register(d, vicious.widgets.fs, function(_, a)
        local p = tonumber(a["{"..mount.." used_p}"]) or 0
        d:set_value(p/100)
        d:set_text(p.."%")
        if p < 70 then
            d:set_color({0.30,0.80,0.35,0.95})
        elseif p < 90 then
            d:set_color({0.90,0.75,0.25,0.95})
        else
            d:set_color({0.92,0.28,0.28,0.95})
        end
    end, 20)
    return d
end

return wibox.widget {
    disk_circle("/",     "root"),
    disk_circle("/boot", "boot"),
    disk_circle("/usr",  "usr"),
    disk_circle("/home", "home"),
    spacing = 6,
    layout  = wibox.layout.fixed.vertical
}
