-- config/signals.lua
-- Sinais de comportamento das janelas

local beautiful = require("beautiful")

-- Foco muda cor da borda
client.connect_signal("focus",
    function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus",
    function(c) c.border_color = beautiful.border_normal end)

-- Foco segue o mouse
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise=false})
end)
