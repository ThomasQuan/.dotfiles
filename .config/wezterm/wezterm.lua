local wez = require "wezterm"
local appearance = require "lua.appearance"
local mappings = require "lua.mappings"
local bar = wez.plugin.require "https://github.com/adriankarlen/bar.wezterm"
wez.on("gui-startup", function(cmd)
  local _, _, window = wez.mux.spawn_window(cmd or {})

  -- Active pane starts full; split right (30%) for the side column
  local left_pane = window:active_pane()

  local right_pane = left_pane:split {
    direction = "Right",
    size = 0.30,
  }

  -- Split the right pane: top 60%, bottom 40%
  right_pane:split {
    direction = "Bottom",
    size = 0.40,
  }

  -- Focus the left (main) pane
  left_pane:activate()
end)

local c = {}

if wez.config_builder then
  c = wez.config_builder()
end

-- General configurations
c.font = wez.font("FiraCode Nerd Font Mono", { weight = "Medium" })
c.font_rules = {
  {
    italic = true,
    font = wez.font("FiraCode Nerd Font Mono", { weight = "Medium", italic = true }),
  },
}
c.font_size = 18
c.command_palette_font_size = 18
c.command_palette_rows = 18
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.scrollback_lines = 3000
c.default_workspace = "main"
c.max_fps = 240
c.term = "wezterm"
-- appearance
appearance.apply_to_config(c)

-- keys
mappings.apply_to_config(c)

-- bar
bar.apply_to_config(c, {
  position = "bottom",
  modules = {
    clock = {
      enabled = false,
    },
    username = {
      icon = "",
    },
  },
})

c.colors = c.colors or {}
c.colors.cursor_bg = "#f6c177"
c.colors.cursor_fg = "#232136"
c.colors.cursor_border = "#f6c177"

return c
