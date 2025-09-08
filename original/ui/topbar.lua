-- ui/topbar.lua
-- Barra superior estilo retrô (minimalista, sem widgets extras)

local awful = require("awful")
local wibox = require("wibox")

return function(s)

    -- Promptbox
    s.mypromptbox = awful.widget.prompt()

    -- Layoutbox
    s.mylayoutbox = awful.widget.layoutbox {
        screen = s,
        buttons = {
            awful.button({}, 1, function () awful.layout.inc(1) end),
            awful.button({}, 3, function () awful.layout.inc(-1) end),
            awful.button({}, 4, function () awful.layout.inc(1) end),
            awful.button({}, 5, function () awful.layout.inc(-1) end),
        }
    }

    -- Taglist (workspaces)
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({}, 1, function(t) t:view_only() end),
            awful.button({ "Mod4" }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
        }
    }

    -- Tasklist (janelas abertas)
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
    }

    -- Barra superior (wibar)
    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        height   = 24,
        bg       = "#121212ee", -- translúcido escuro
        fg       = "#DDDCFF"
    }

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Esquerda
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Centro
        { -- Direita
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            s.mylayoutbox,
        },
    }
end
