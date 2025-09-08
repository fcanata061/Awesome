-- ui/topbar.lua
-- Barra superior clássica do Awesome

local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

return function(s)
    -- Criar tags (áreas de trabalho)
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Prompt box (entrada de comandos)
    s.mypromptbox = awful.widget.prompt()

    -- Layout box (mostra layout atual)
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)
    ))

    -- Lista de tags (áreas de trabalho)
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = gears.table.join(
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end)
        )
    }

    -- Lista de tarefas (janelas abertas)
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = gears.table.join(
            awful.button({ }, 1, function (c)
                if c == client.focus then
                    c.minimized = true
                else
                    c:emit_signal("request::activate", "tasklist", {raise = true})
                end
            end)
        )
    }

    -- Relógio
    s.mytextclock = wibox.widget.textclock("%a %d %b %H:%M ")

    -- Cria a wibar (barra superior)
    s.mywibar = awful.wibar({
        position = "top",
        screen   = s,
        height   = 24,
        bg       = beautiful.bg_normal,
        fg       = beautiful.fg_normal
    })

    -- Coloca os widgets na barra
    s.mywibar:setup {
        layout = wibox.layout.align.horizontal,
        { -- lado esquerdo
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- centro
        { -- lado direito
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            s.mytextclock,
            s.mylayoutbox,
        },
    }
end
