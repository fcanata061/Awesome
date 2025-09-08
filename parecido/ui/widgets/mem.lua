-- ui/widgets/mem.lua
local lain   = require("lain")
local circle = require("ui.widgets.lib.fancy_circle")

local memc = circle({ diameter = 72, label = "MEM" })
lain.widgets.mem({
    settings = function()
        local p = tonumber(mem_now.perc) or 0
        local u = tonumber(mem_now.used) or 0
        memc:set_value(p/100)
        memc:set_text(p.."%\n"..u.."MB")
        if p < 60 then
            memc:set_color({0.30,0.80,0.35,0.95})
        elseif p < 85 then
            memc:set_color({0.90,0.75,0.25,0.95})
        else
            memc:set_color({0.92,0.28,0.28,0.95})
        end
    end
})
return memc
