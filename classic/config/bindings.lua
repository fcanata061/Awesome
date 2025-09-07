local awful = require("awful")
local gears = require("gears")
local vars  = require("config.variables")

local bindings = {}

-- Global keys
bindings.globalkeys = gears.table.join(
    awful.key({ vars.modkey }, "Return", function() awful.spawn(vars.terminal) end,
              {description = "Abrir terminal", group = "launcher"}),

    awful.key({ vars.modkey, "Control" }, "r", awesome.restart,
              {description = "Reiniciar awesome", group = "awesome"}),

    awful.key({ vars.modkey, "Shift" }, "q", awesome.quit,
              {description = "Sair do awesome", group = "awesome"}),

    awful.key({ vars.modkey }, "b", function() awful.spawn(vars.browser) end,
              {description = "Abrir navegador", group = "launcher"})
)

-- Global mouse buttons
bindings.globalbuttons = gears.table.join(
    awful.button({ }, 3, function () if mymainmenu then mymainmenu:toggle() end end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
)

return bindings
