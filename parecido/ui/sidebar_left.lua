-- ui/sidebar_left.lua
-- Barra lateral esquerda em círculos preenchidos
local awful   = require("awful")
local wibox   = require("wibox")
local vicious = require("vicious")
local lain    = require("lain")
local ring    = require("ui.widgets.lib.filled_circle") -- novo widget preenchido

return function(s)

  ---------------------------------------------------
  -- CPU: 8 núcleos (círculos preenchidos verticais)
  ---------------------------------------------------
  local cpu_list = wibox.widget {
    spacing = 6,
    layout  = wibox.layout.fixed.vertical
  }

  for i=1,8 do
    local c = ring({ size=60, label="CPU"..i })
    vicious.register(c, vicious.widgets.cpu, function(_, args)
      local usage = tonumber(args[i+1]) or 0
      c:set_value(usage/100)
      c:set_text(usage.."%")
    end, 2)
    cpu_list:add(c)
  end

  ---------------------------------------------------
  -- MEM
  ---------------------------------------------------
  local mem_circle = ring({ size=80, label="MEM" })
  lain.widgets.mem({
    settings = function()
      local p = tonumber(mem_now.perc) or 0
      local u = tonumber(mem_now.used) or 0
      mem_circle:set_value(p/100)
      mem_circle:set_text(p.."%\n"..u.."MB")
    end
  })

  ---------------------------------------------------
  -- NET (círculo duplo: DL/UL)
  ---------------------------------------------------
  local net_down = ring({ size=70, label="↓" })
  local net_up   = ring({ size=50, label="↑", inner=true })

  vicious.register(net_down, vicious.widgets.net, function(_, args)
    local kb = tonumber(args["{wlan0 down_kb}"]) or 0
    net_down:set_value(math.min(kb/1000, 1))
    net_down:set_text("↓\n"..kb.."kB/s")
  end, 2, "wlan0")

  vicious.register(net_up, vicious.widgets.net, function(_, args)
    local kb = tonumber(args["{wlan0 up_kb}"]) or 0
    net_up:set_value(math.min(kb/1000, 1))
    net_up:set_text("↑\n"..kb.."kB/s")
  end, 2, "wlan0")

  local net_circle = wibox.widget {
    net_down,
    net_up,
    layout = wibox.layout.stack
  }

  ---------------------------------------------------
  -- DISKS
  ---------------------------------------------------
  local function disk_circle(mount, label)
    local d = ring({ size=65, label=label })
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
    spacing = 6,
    layout  = wibox.layout.fixed.vertical
  }

  ---------------------------------------------------
  -- Construir a barra lateral
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
    spacing = 10,

    cpu_list,
    mem_circle,
    net_circle,
    disks,
  }
end
