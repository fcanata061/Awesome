-- ui/widgets/init.lua
-- Carrega todos os widgets modernos

local widgets = {}

widgets.cpu     = require("ui.widgets.cpu")
widgets.mem     = require("ui.widgets.mem")
widgets.disk    = require("ui.widgets.disk")
widgets.net     = require("ui.widgets.net")
widgets.battery = require("ui.widgets.battery")
widgets.volume  = require("ui.widgets.volume")
widgets.clock   = require("ui.widgets.clock")

return widgets
