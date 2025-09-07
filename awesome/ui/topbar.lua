-- ui/topbar.lua
-- Barra superior

local awful = require("awful")
local wibox = require("wibox")
local wi    = require("ui.widgets")

return function(s)

    -- Prompt
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

    -- Taglist
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({}, 1, function(t) t:view_only() end),
            awful.button({ "Mod4" }, 1, function(t) if client.focus then client.focus:move_to_tag(t) end end),
        }
    }

    -- Tasklist
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
    }

    -- Criar a wibar superior
    s.mywibox = awful.wibar { position = "top", screen = s, height = 28 }

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Esquerda
            layout = wibox.layout.fixed.horizontal,
            wi.mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Meio
        { -- Direita
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            wi.volumewidget,
            wi.batwidget,
            wi.memwidget,
            wi.cpuwidget,
            wi.mytextclock,
            s.mylayoutbox,
        },
    }
end
