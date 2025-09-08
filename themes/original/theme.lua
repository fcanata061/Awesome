-- ~/.config/awesome/retro/themes/retro/theme.lua
-- Tema estilo blingbling retrô

local theme = {}
local home     = os.getenv("HOME")
local themedir = home .. "/.config/awesome/retro/themes/retro"

-- 🎨 Paleta de cores retrô
theme.fg_normal   = "#DDDCFF"
theme.fg_focus    = "#FFFFFF"
theme.fg_urgent   = "#EB8F8F"
theme.bg_normal   = "#121212ee"
theme.bg_focus    = "#1E1E1Ecc"
theme.bg_urgent   = "#2A1F1Ecc"

-- Bordas
theme.border_width  = 2
theme.border_normal = "#222222"
theme.border_focus  = "#7A5ADA"
theme.border_marked = "#91231c"

-- Gaps
theme.useless_gap   = 4

-- Fontes
theme.font          = "Terminus 12"
theme.taglist_font  = "Terminus Bold 13"

-- Menu
theme.menu_height   = 24
theme.menu_width    = 120

-- Wallpaper (ajuste para o seu)
theme.wallpaper     = themedir .. "/wall.jpg"

-- Ícones de layout (pode copiar do tema padrão do awesome)
theme.layout_tile       = themedir .. "/icons/tile.png"
theme.layout_floating   = themedir .. "/icons/floating.png"
theme.layout_max        = themedir .. "/icons/max.png"

-- Taglist squares (clássico blingbling quadradinhos)
theme.taglist_squares_sel   = themedir .. "/icons/square_sel.png"
theme.taglist_squares_unsel = themedir .. "/icons/square_unsel.png"

return theme
