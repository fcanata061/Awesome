-- ui/widgets/cpu.lua
local vicious = require("vicious")
local circle  = require("ui.widgets.lib.fancy_circle")

local cpu_widgets = {}
vicious.cache(vicious.widgets.cpu)

for i=1,8 do
    local c = circle({ diameter = 56, label = "CPU"..i })
    vicious.register(c, vicious.widgets.cpu, function(_, args)
        local u = tonumber(args[i+1]) or 0
        c:set_value(u/100)
        c:set_text(u.."%")
        if u < 60 then
            c:set_color({0.30,0.80,0.35,0.95})
        elseif u < 85 then
            c:set_color({0.90,0.75,0.25,0.95})
        else
            c:set_color({0.92,0.28,0.28,0.95})
        end
    end, 2)
    table.insert(cpu_widgets, c)
end

return cpu_widgets
