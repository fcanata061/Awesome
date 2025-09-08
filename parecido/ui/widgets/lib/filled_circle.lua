-- ui/widgets/lib/filled_circle.lua
-- Círculo preenchido com Cairo
local wibox = require("wibox")
local lgi   = require("lgi")
local cairo = lgi.cairo

local function new(opts)
  opts = opts or {}
  local w = wibox.widget.base.make_widget()

  w.value  = opts.value or 0
  w.size   = opts.size or 60
  w.label  = opts.label or ""
  w.text   = opts.text or ""
  w.inner  = opts.inner or false -- para círculos internos (como upload no net)

  function w:set_value(v) self.value = math.max(0, math.min(1, v)); self:emit_signal("widget::redraw_needed") end
  function w:set_text(t) self.text = t or ""; self:emit_signal("widget::redraw_needed") end

  function w:fit(_, width, height) return self.size, self.size end

  function w:draw(_, cr, width, height)
    local cx, cy = width/2, height/2
    local r = (math.min(width,height)/2) - 4

    -- fundo
    cr:arc(cx, cy, r, 0, 2*math.pi)
    cr:set_source_rgba(0.15,0.15,0.15,0.9)
    cr:fill()

    -- preenchimento
    cr:arc(cx, cy, r * (self.inner and 0.7 or 1.0), -math.pi/2, -math.pi/2 + (2*math.pi*self.value))
    cr:line_to(cx, cy)
    cr:close_path()
    cr:set_source_rgba(0.3,0.7,1.0,0.8)
    cr:fill()

    -- texto
    if self.text and self.text ~= "" then
      cr:set_source_rgba(1,1,1,1)
      cr:select_font_face("Terminus", cairo.FontSlant.NORMAL, cairo.FontWeight.BOLD)
      cr:set_font_size(10)
      local ext = cr:text_extents(self.text)
      cr:move_to(cx - ext.width/2, cy + ext.height/2)
      cr:show_text(self.text)
    end
  end

  return w
end

return setmetatable({}, { __call = function(_, ...) return new(...) end })
