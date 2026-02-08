local wez = require "wezterm"
local act = wez.action
local callback = wez.action_callback

local mod = {
  c = "CTRL",
  s = "SHIFT",
  a = "ALT",
  l = "LEADER",
}

local keybind = function(mods, key, action)
  return { mods = table.concat(mods, "|"), key = key, action = action }
end

local M = {}

-- CTRL-A as the leader key
local leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

local keys = function()
  local keys = {
    -- Pane movement using CTRL-A + h/j/k/l
    keybind({ mod.l }, "h", act.ActivatePaneDirection "Left"),
    keybind({ mod.l }, "j", act.ActivatePaneDirection "Down"),
    keybind({ mod.l }, "k", act.ActivatePaneDirection "Up"),
    keybind({ mod.l }, "l", act.ActivatePaneDirection "Right"),

    -- Split panes using CTRL-A + \ or /
    keybind({ mod.l }, "\\", act.SplitHorizontal { domain = "CurrentPaneDomain" }),
    keybind({ mod.l }, "/", act.SplitVertical { domain = "CurrentPaneDomain" }),

    -- Toggle zoom for pane
    keybind({ mod.l }, "z", act.TogglePaneZoomState),

    -- Tab management
    keybind({ mod.l }, "c", act.SpawnTab "CurrentPaneDomain"),
    keybind({ mod.l, mod.s }, "&", act.CloseCurrentTab { confirm = true }),

    -- Close current pane
    keybind({ mod.l }, "x", act.CloseCurrentPane { confirm = true }),

    -- Resize panes with CTRL-A + Shift + H/J/K/L
    keybind({ mod.l, mod.s }, "H", act.AdjustPaneSize { "Left", 5 }),
    keybind({ mod.l, mod.s }, "J", act.AdjustPaneSize { "Down", 5 }),
    keybind({ mod.l, mod.s }, "K", act.AdjustPaneSize { "Up", 5 }),
    keybind({ mod.l, mod.s }, "L", act.AdjustPaneSize { "Right", 5 }),

    -- Rename tab
    keybind(
      { mod.l },
      "e",
      act.PromptInputLine {
        description = wez.format {
          { Attribute = { Intensity = "Bold" } },
          { Foreground = { AnsiColor = "Fuchsia" } },
          { Text = "Renaming Tab Title...:" },
        },
        action = callback(function(win, _, line)
          if line ~= "" then
            win:active_tab():set_title(line)
          end
        end),
      }
    ),

    -- Workspaces
    keybind({ mod.l }, "w", act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" }),

    -- Copy and paste
    keybind({ mod.c, mod.s }, "c", act.CopyTo "Clipboard"),
    keybind({ mod.c, mod.s }, "v", act.PasteFrom "Clipboard"),

    -- Launch Spotify player as a small pane at the bottom
    keybind(
      { mod.l },
      "s",
      act.SplitPane {
        direction = "Down",
        command = { args = { "spotify_player" } },
        size = { Cells = 6 },
      }
    ),

    -- Update all plugins
    keybind(
      { mod.l },
      "u",
      callback(function(win)
        wez.plugin.update_all()
        win:toast_notification("wezterm", "plugins updated!", nil, 4000)
      end)
    ),
  }

  -- Tab navigation with CTRL-A + 1-9
  for i = 1, 9 do
    table.insert(keys, keybind({ mod.l }, tostring(i), act.ActivateTab(i - 1)))
  end

  return keys
end

M.apply_to_config = function(c)
  c.treat_left_ctrlalt_as_altgr = true
  c.leader = leader
  c.keys = keys()
end

return M
