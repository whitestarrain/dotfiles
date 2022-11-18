-- 加载该文件配置，~/.config/wezterm/wezterm.lua中加上以下代码
-- package.path = package.path..";D:/MyRepo/dotfiles/?.lua"
-- local wezterm_config = require 'wezterm_config'
-- return wezterm_config

local wezterm = require("wezterm")

return {
	font = wezterm.font("Hack NF"),
	font_size = 14,

	default_prog = { "pwsh" },

	window_background_opacity = 0.9,
	text_background_opacity = 1.0,

	enable_tab_bar = true,

	hide_tab_bar_if_only_one_tab = true,

	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.8,
	},

	set_environment_variables = {
		WEZTERM = "wezterm",
	},

	initial_cols = 150,
	initial_rows = 42,

	-- tab bar
	window_frame = {
		font = wezterm.font({ family = "Roboto", weight = "Bold" }),
		font_size = 12.0,
		active_titlebar_bg = "#23272e",
		inactive_titlebar_bg = "#23272e",
	},
	colors = {
		tab_bar = {
			background = "#1a1a21",
			active_tab = {
				bg_color = "#191919",
				fg_color = "#c0c0c0",
				intensity = "Normal",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			inactive_tab = {
				bg_color = "#1a1a21",
				fg_color = "#616161",
			},
			inactive_tab_hover = {
				bg_color = "#1a1a21",
				fg_color = "#909090",
				italic = true,
			},
			new_tab = {
				bg_color = "#1a1a21",
				fg_color = "#616161",
			},
			new_tab_hover = {
				bg_color = "#3b3052",
				fg_color = "#909090",
				italic = true,
			},
		},
		selection_fg = "black",
		selection_bg = "#fffacd",
		scrollbar_thumb = "#222222",
		split = "#444444",
		ansi = { "black", "maroon", "green", "olive", "navy", "purple", "teal", "silver" },
		brights = { "grey", "red", "lime", "yellow", "blue", "fuchsia", "aqua", "white" },
		indexed = { [136] = "#af8700" },
	},

	window_padding = {
		left = "1cell",
		right = "1cell",
		top = "0cell",
		bottom = "0cell",
	},

	color_schemes = {
		-- ref: https://github.com/wez/wezterm/blob/main/assets/colors/OneHalfDark.toml
		["My one dark"] = {
			foreground = "#a1a170",
			background = "#1e2127",
			cursor_bg = "#abb2bf",
			cursor_fg = "black",
			cursor_border = "#52ad70",
			selection_bg = "#ebdbb2",
			selection_fg = "black",
			ansi = { "#282c34", "#c96169", "#98c379", "#e5c07b", "#569bd4", "#c678dd", "#56b6c2", "#dcdfe4" },
			brights = { "#565f70", "#ff7a86", "#b5e890", "#ffd689", "#67bbff", "#e48aff", "#69deed", "#a1a199" },
		},
	},
	color_scheme = "My one dark",
}
