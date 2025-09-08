-- config/rules.lua
-- Regras para clientes (janelas)

local awful = require("awful")
local beautiful = require("beautiful")

awful.rules.rules = {
    -- Padrão para todas as janelas
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus        = awful.client.focus.filter,
            raise        = true,
            keys         = clientkeys,
            buttons      = clientbuttons,
            screen       = awful.screen.preferred,
            placement    = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    -- Floating para apps específicos
    { rule_any = {
        class = { "Gimp", "Arandr", "Pavucontrol" },
    }, properties = { floating = true } },

    -- Firefox abre na tag 2
    { rule = { class = "Firefox" },
      properties = { screen = 1, tag = "2" } },
}
