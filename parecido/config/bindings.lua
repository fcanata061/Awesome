-- config/bindings.lua
-- Atalhos de teclado e mouse

local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Teclas globais
globalkeys = gears.table.join(
    -- Mostrar ajuda
    awful.key({ modkey, }, "s", hotkeys_popup.show_help,
              {description="mostrar ajuda", group="awesome"}),

    -- Básicos
    awful.key({ modkey, }, "Return", function () awful.spawn(terminal) end,
              {description = "abrir terminal", group = "launcher"}),

    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reiniciar awesome", group = "awesome"}),

    awful.key({ modkey, "Shift" }, "q", awesome.quit,
              {description = "sair do awesome", group = "awesome"}),

    -- Navegação entre tags
    awful.key({ modkey, }, "Left",  awful.tag.viewprev,
              {description = "tag anterior", group = "tag"}),
    awful.key({ modkey, }, "Right", awful.tag.viewnext,
              {description = "próxima tag", group = "tag"}),

    -- Foco entre clientes
    awful.key({ modkey, }, "j", function () awful.client.focus.byidx( 1) end,
              {description = "focar próximo", group = "client"}),
    awful.key({ modkey, }, "k", function () awful.client.focus.byidx(-1) end,
              {description = "focar anterior", group = "client"}),

    -- Alternar layouts
    awful.key({ modkey, }, "space", function () awful.layout.inc( 1) end,
              {description = "próximo layout", group = "layout"}),
    awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(-1) end,
              {description = "layout anterior", group = "layout"})
)

-- Bindings por cliente (janelas)
clientkeys = gears.table.join(
    awful.key({ modkey, }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "alternar tela cheia", group = "client"}),

    awful.key({ modkey, "Shift" }, "c", function (c) c:kill() end,
              {description = "fechar", group = "client"}),

    awful.key({ modkey, }, "t", function (c) c.ontop = not c.ontop end,
              {description = "alternar sempre no topo", group = "client"})
)

-- Bindings do mouse
clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),
    awful.button({ modkey }, 1, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true}); awful.mouse.client.move(c) end),
    awful.button({ modkey }, 3, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true}); awful.mouse.client.resize(c) end)
)

-- Aplicar
root.keys(globalkeys)
