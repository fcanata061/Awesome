-- ui/widgets/lib/fancy_circle.lua
-- Círculo preenchido com gradiente, contorno e glow (para dock lateral estreita)
local wibox = require("wibox")
local lgi   = require("lgi")
local cairo = lgi.cairo

local function new(opts)
  opts = opts or {}
  local W = wibox.widget.base.make_widget()

  -- Config
  W.diameter = opts.diameter or 60
  W.value    = opts.value or 0       -- 0..1
  W.label    = opts.label or ""      -- texto superior
  W.text     = opts.text or ""       -- texto inferior
  W.inner    = opts.inner or false
  W.scale    = opts.scale or 0.75

  -- Paleta base
  W.color    = opts.color or {0.4,0.7,1.0,1}   -- azul padrão
  W.bg       = {0.1,0.1,0.1,0.9}
  W.glow     = true

  function W:set_value(v) self.value = math.max(0, math.min(1, v or 0)); self:emit_signal("widget::redraw_needed") end
  function W:set_text(t)  self.text  = t or ""; self:emit_signal("widget::redraw_needed") end
  function W:set_label(t) self.label = t or ""; self:emit_signal("widget::redraw_needed") end
  function W:set_color(c) self.color = c; self:emit_signal("widget::redraw_needed") end

  function W:fit(_, w, h) return self.diameter, self.diameter end

  local function rgba(cr, c) cr:set_source_rgba(c[1],c[2],c[3],c[4] or 1) end

  function W:draw(_, cr, w, h)
    local d = math.min(w,h)
    local cx, cy = w/2, h/2
    local r = (d/2) - 3
    if self.inner then r = r*self.scale end

    -- fundo
    cr:arc(cx,cy,r,0,2*math.pi)
    rgba(cr, self.bg)
    cr:fill()

    -- preenchimento com gradiente radial
    local ang = -math.pi/2 + (2*math.pi*self.value)
    cr:move_to(cx,cy)
    cr:arc(cx,cy,r,-math.pi/2,ang)
    cr:close_path()
    local grad = cairo.Pattern.create_radial(cx,cy,0, cx,cy,r)
    grad:add_color_stop_rgba(0, self.color[1],self.color[2],self.color[3],0.8)
    grad:add_color_stop_rgba(1, self.color[1]*0.6,self.color[2]*0.6,self.color[3]*0.6,1)
    cr:set_source(grad)
    cr:fill()

    -- contorno duplo
    cr:set_line_width(2)
    cr:arc(cx,cy,r,0,2*math.pi)
    rgba(cr,{1,1,1,0.1})
    cr:stroke()

    cr:set_line_width(1)
    cr:arc(cx,cy,r-1,0,2*math.pi)
    rgba(cr,self.color)
    cr:stroke()

    -- glow externo
    if self.glow and self.value > 0.7 then
      cr:save()
      local gpat = cairo.Pattern.create_radial(cx,cy,r, cx,cy,r+8)
      gpat:add_color_stop_rgba(0.0,self.color[1],self.color[2],self.color[3],0.3)
      gpat:add_color_stop_rgba(1.0,self.color[1],self.color[2],self.color[3],0.0)
      cr:set_source(gpat)
      cr:arc(cx,cy,r+8,0,2*math.pi)
      cr:fill()
      cr:restore()
    end

    -- textos
    cr:select_font_face("Terminus", cairo.FontSlant.NORMAL, cairo.FontWeight.BOLD)

    if self.label ~= "" then
      cr:set_font_size(9)
      rgba(cr,{0.8,0.8,0.95,0.9})
      local ext = cr:text_extents(self.label)
      cr:move_to(cx-ext.width/2, cy-2)
      cr:show_text(self.label)
    end

    if self.text ~= "" then
      cr:set_font_size(11)
      rgba(cr,{1,1,1,1})
      local ext = cr:text_extents(self.text)
      cr:move_to(cx-ext.width/2, cy+12)
      cr:show_text(self.text)
    end
  end

  return W
end

return setmetatable({}, { __call = function(_, ...) return new(...) end })
