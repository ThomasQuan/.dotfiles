local wezterm = require("wezterm")
local act = wezterm.action

return {
	leader = {
		key = "a",
		mods = "CTRL",
	},

	keys = {
		{
			key = "w",
			mods = "CMD",
			action = act.CloseCurrentPane({
				confirm = true,
			}),
		}, -- activate resize mode
		{
			key = "r",
			mods = "LEADER",
			action = act.ActivateKeyTable({
				name = "resize_pane",
				one_shot = false,
			}),
		}, -- focus panes
		{
			key = "l",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "h",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Down"),
		}, -- add new panes
		{
			key = "/",
			mods = "LEADER",
			action = act.SplitVertical({
				domain = "CurrentPaneDomain",
			}),
		},
		{
			key = "\\",
			mods = "LEADER",
			action = act.SplitHorizontal({
				domain = "CurrentPaneDomain",
			}),
		},
	},

	key_tables = {
		resize_pane = {
			{
				key = "LeftArrow",
				action = act.AdjustPaneSize({ "Left", 5 }),
			},
			{
				key = "RightArrow",
				action = act.AdjustPaneSize({ "Right", 5 }),
			},
			{
				key = "UpArrow",
				action = act.AdjustPaneSize({ "Up", 2 }),
			},
			{
				key = "DownArrow",
				action = act.AdjustPaneSize({ "Down", 2 }),
			},
			{
				key = "Escape",
				action = "PopKeyTable",
			},
		},
	},
}
