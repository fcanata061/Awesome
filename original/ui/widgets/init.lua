-- ui/widgets/init.lua
-- Hub dos widgets estilo blingbling (retro reimplementado)

local widgets = {}

widgets.cpu    = require("ui.widgets.cpu")
widgets.mem    = require("ui.widgets.mem")
widgets.disk   = require("ui.widgets.disk")
widgets.net    = require("ui.widgets.net")
widgets.volume = require("ui.widgets.volume")

return widgets
