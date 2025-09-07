
-- ~/.config/awesome/modern/themes/modern/theme.lua
-- Tema clean e moderno

local theme = {}
local home     = os.getenv("HOME")
local themedir = home .. "/.config/awesome/modern/themes/modern"

-- 🎨 Cores principais
theme.fg_normal   = "#DDDCFF"
theme.fg_focus    = "#FFFFFF"
theme.fg_urgent   = "#EB8F8F"
theme.bg_normal   = "#121212aa" -- translúcido
theme.bg_focus    = "#1E1E1Ecc"
theme.bg_urgent   = "#2A1F1Ecc"

-- Bordas
theme.border_width  = 2
theme.border_normal = "#121212"
theme.border_focus  = "#7A5ADA"

-- Gaps
theme.useless_gap   = 6

-- Fontes
theme.font          = "FiraCode Nerd Font 12"
theme.taglist_font  = "FiraCode Nerd Font 13"

-- Menu
theme.menu_height   = 30
theme.menu_width    = 120
theme.menu_submenu_icon = themedir .. "/icons/submenu.png"

-- Wallpaper (coloque sua imagem aqui)
theme.wallpaper     = themedir .. "/wall.jpg"

-- Ícones de layout (modernizados ou pode usar padrão do awesome)
theme.layout_tile       = themedir .. "/icons/tile.png"
theme.layout_floating   = themedir .. "/icons/floating.png"
theme.layout_max        = themedir .. "/icons/max.png"

-- Ícones de taglist
theme.taglist_squares_sel   = themedir .. "/icons/square_sel.png"
theme.taglist_squares_unsel = themedir .. "/icons/square_unsel.png"

return theme
