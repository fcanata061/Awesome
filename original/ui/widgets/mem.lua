-- ui/widgets/mem.lua
-- Reimplementação do blingbling MEM em Awesome moderno

local wibox   = require("wibox")
local vicious = require("vicious")

---------------------------------------------------
-- Barra de memória (progress graph)
---------------------------------------------------
local mem_bar = wibox.widget {
    max_value     = 100,
    value         = 0,
    forced_height = 20,
    forced_width  = 160,
    color         = "#41F300",
    background_color = "#222222",
    border_width  = 1,
    border_color  = "#444444",
    widget        = wibox.widget.progressbar
}

-- Atualizar com vicious
vicious.register(mem_bar, vicious.widgets.mem,
    function(_, args)
        local used = args[1] or 0
        mem_bar.value = used

        if used < 60 then
            mem_bar.color = "#41F300" -- verde
        elseif used < 85 then
            mem_bar.color = "#E3E34E" -- amarelo
        else
            mem_bar.color = "#EB8F8F" -- vermelho
        end
    end,
    5
)

---------------------------------------------------
-- Label MEM
---------------------------------------------------
local mem_label = wibox.widget {
    markup = "<span foreground='#DDDCFF'>MEM</span>",
    align  = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

---------------------------------------------------
-- Layout final
---------------------------------------------------
local mem_widget = w
