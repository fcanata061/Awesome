-- ui/sidebar_left.lua
-- Barra lateral esquerda toda em círculos (CPU, MEM, NET, DISKS)
local awful    = require("awful")
local wibox    = require("wibox")
local vicious  = require("vicious")
local lain     = require("lain")
local ring     = require("ui.widgets.lib.ring")

return function(s)

  ---------------------------------------------------
  -- CPU: 8 núcleos circulares
  ---------------------------------------------------
  local cpu_grid = wibox.widget {
    homogeneous     = true,
    expand          = true,
    forced_num_cols = 2,
    spacing         = 8,
    layout          = wibox.layout.grid
  }

  for i=1,8 do
    local c = ring({ thickness=8, text="CPU"..i })
    vicious.register(c, vicious.widgets.cpu, function(_, args)
      local usage = (args[i+1] or 0)
      c:set_value(usage/100)
      c:set_text(string.format("CPU%d\n%d%%", i, usage))
    end, 2)
    cpu_grid:add(c)
  end

  ---------------------------------------------------
  -- MEM: círculo único
  ---------------------------------------------------
  local mem_circle = ring({ thickness=12, text="MEM" })
  lain.widgets.mem({
    settings = function()
      local p = tonumber(mem_now.perc) or 0
      mem_circle:set_value(p/100)
      mem_circle:set_text(string.format("MEM\n%d%%\n%dMB", p, mem_now.used))
    end
  })

  ---------------------------------------------------
  -- NET: círculo duplo (Download externo, Upload interno)
  ---------------------------------------------------
  local net_down = ring({ thickness=12, text="↓" })
  local net_up   = ring({ thickness=6,  text="↑" })

  vicious.register(net_down, vicious.widgets.net, function(_, args)
    local kb = tonumber(args["{wlan0 down_kb}"]) or 0
    net_down:set_value(math.min(kb/1000,1))
    net_down:set_text("↓ "..kb.."kB/s")
  end, 2, "wlan0")

  vicious.register(net_up, vicious.widgets.net, function(_, args)
    local kb = tonumber(args["{wlan0 up_kb}"]) or 0
    net_up:set_value(math.min(kb/1000,1))
    net_up:set_text("↑ "..kb.."kB/s")
  end, 2, "wlan0")

  local net_circle = wibox.widget {
    net_down,
    net_up,
    layout = wibox.layout.stack
  }

  ---------------------------------------------------
  -- DISKS: cada partição um círculo
  ---------------------------------------------------
  local function disk_circle(mount, label)
    local d = ring({ thickness=10, text=label })
    vicious.register(d, vicious.widgets.fs, function(_, args)
      local p = tonumber(args["{"..mount.." used_p}"]) or 0
      d:set_value(p/100)
      d:set_text(label.."\n"..p.."%")
    end, 20)
    return d
  end

  local disks = wibox.widget {
    disk_circle("/", "root"),
    disk_circle("/boot", "boot"),
    disk_circle("/usr", "usr"),
    disk_circle("/home", "home"),
    spacing = 8,
    layout  = wibox.layout.fixed.horizontal
  }

  ---------------------------------------------------
  -- Construir a sidebar
  ---------------------------------------------------
  s.myleftbar = awful.wibar {
    position = "left",
    screen   = s,
    width    = 180,
    bg       = "#121212ee",
    fg       = "#DDDCFF"
  }

  s.myleftbar:setup {
    layout  = wibox.layout.fixed.vertical,
    spacing = 12,

    cpu_grid,
    mem_circle,
    net_circle,
    disks,
  }
end
