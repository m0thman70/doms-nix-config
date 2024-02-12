local wezterm = require "wezterm"

return {
  enable_tab_bar = false,
  font_size = 15,
  
  font = wezterm.font ('Terminus'),

  color_scheme = "Personal",
  color_schemes = {
    ["Personal"] = {
      foreground = "#8ca68c",
      background = "#060a16",
      cursor_bg = "#8ca68c"
      },
   },
}
