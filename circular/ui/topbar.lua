-- ui/topbar.lua - minimalista

local awful = require("awful")
local wibox = require("wibox")

return function(s)
    s.mypromptbox = awful.widget.prompt()
    s.mylayoutbox = awful.widget.layoutbox(s)

    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all
    }

    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags
    }

    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        height   = 24,
        bg       = "#121212ee",
        fg       = "#DDDCFF"
    }

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { layout = wibox.layout.fixed.horizontal, s.mytaglist, s.mypromptbox },
        s.mytasklist,
        { layout = wibox.layout.fixed.horizontal, wibox.widget.systray(), s.mylayoutbox },
    }
end
