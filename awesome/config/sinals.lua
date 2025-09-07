local awful = require("awful")
local beautiful = require("beautiful")

-- Foco e bordas
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Sloppy focus (foco ao passar o mouse)
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise=false})
end)
