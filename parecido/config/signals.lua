-- config/signals.lua
-- Sinais de comportamento dos clientes

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

-- Borda focada e não focada
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Garante que janelas não abram fora da tela
client.connect_signal("manage", function (c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

-- Reduz opacidade de unfocused (efeito bonito)
client.connect_signal("focus",   function(c) c.opacity = 1 end)
client.connect_signal("unfocus", function(c) c.opacity = 0.85 end)
