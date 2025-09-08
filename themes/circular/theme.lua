local theme = {}
local home     = os.getenv("HOME")
local themedir = home .. "/.config/awesome/all-circles/themes/all-circles"

-- Paleta
theme.fg_normal   = "#DDDCFF"
theme.fg_focus    = "#FFFFFF"
theme.bg_normal   = "#121212ee"
theme.bg_focus    = "#1E1E1Ecc"

theme.border_width  = 2
theme.border_normal = "#222222"
theme.border_focus  = "#7A5ADA"

theme.useless_gap   = 4
theme.font          = "Terminus 12"

theme.menu_height   = 24
theme.menu_width    = 120

theme.wallpaper     = themedir .. "/wall.jpg"

return theme
