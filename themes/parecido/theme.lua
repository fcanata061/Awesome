------------------------------
--   Tema All Circles Fancy --
------------------------------

local gears = require("gears")

local theme = {}

-- Fonte padrão
theme.font          = "Terminus Bold 10"

-- Cores principais
theme.bg_normal     = "#121212ee"
theme.bg_focus      = "#1f1f1fee"
theme.bg_urgent     = "#ff0000aa"
theme.bg_minimize   = "#444444aa"

theme.fg_normal     = "#DDDCFF"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#bbbbbb"

-- Bordas
theme.useless_gap   = 6
theme.border_width  = 2
theme.border_normal = "#222222"
theme.border_focus  = "#7e57c2" -- roxo neon
theme.border_marked = "#91231c"

-- Layouts (ícones padrão)
theme.layout_tile       = gears.filesystem.get_themes_dir().."default/layouts/tilew.png"
theme.layout_tileleft   = gears.filesystem.get_themes_dir().."default/layouts/tileleftw.png"
theme.layout_tilebottom = gears.filesystem.get_themes_dir().."default/layouts/tilebottomw.png"
theme.layout_tiletop    = gears.filesystem.get_themes_dir().."default/layouts/tiletopw.png"
theme.layout_fairv      = gears.filesystem.get_themes_dir().."default/layouts/fairvw.png"
theme.layout_fairh      = gears.filesystem.get_themes_dir().."default/layouts/fairhw.png"
theme.layout_spiral     = gears.filesystem.get_themes_dir().."default/layouts/spiralw.png"
theme.layout_dwindle    = gears.filesystem.get_themes_dir().."default/layouts/dwindlew.png"
theme.layout_max        = gears.filesystem.get_themes_dir().."default/layouts/maxw.png"
theme.layout_fullscreen = gears.filesystem.get_themes_dir().."default/layouts/fullscreenw.png"
theme.layout_magnifier  = gears.filesystem.get_themes_dir().."default/layouts/magnifierw.png"
theme.layout_floating   = gears.filesystem.get_themes_dir().."default/layouts/floatingw.png"

-- Wallpaper
theme.wallpaper = gears.filesystem.get_configuration_dir() .. "themes/all-circles/wall.jpg"

-- Systray
theme.systray_icon_spacing = 6
theme.bg_systray = theme.bg_normal

return theme
