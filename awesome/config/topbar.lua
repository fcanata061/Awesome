local awful = require("awful")
local wibox = require("wibox")
local vars  = require("config.variables")
local wi    = require("wi")  -- reaproveita seus widgets antigos

return function(s)
    -- Criar promptbox, layoutbox, taglist, tasklist
    s.mypromptbox = awful.widget.prompt()
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mytaglist   = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
    }
    s.mytasklist  = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
    }

    -- Barra superior
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 30 })

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
            wi.volume_master,
            wi.batwidget,
            wi.uptimewidget,
            wi.mytextclock,
            s.mylayoutbox,
        },
    }
end
