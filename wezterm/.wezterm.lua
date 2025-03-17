-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- config.color_scheme = "Tokyo Night"
config.color_scheme = "Tokyo Night"
-- my coolnight colorscheme
-- config.colors = {
-- 	foreground = "#CBE0F0",
-- 	background = "#011423",
-- 	cursor_bg = "#47FF9C",
-- 	cursor_border = "#47FF9C",
-- 	cursor_fg = "#011423",
-- 	selection_bg = "#033259",
-- 	selection_fg = "#CBE0F0",
-- 	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
-- 	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
-- }

-- wezterm.font("FiraMono Nerd Font Mono", { weight = "Bold", italic = false })
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font = wezterm.font_with_fallback({
	{ family = "CaskaydiaCove Nerd Font" },
})

config.font_size = 13

config.enable_tab_bar = false

-- config.window_decorations = "RESIZE"
config.window_decorations = "NONE"
config.window_background_opacity = 0.75
config.macos_window_background_blur = 10

config.line_height = 1.0

--margin and padding
config.window_padding = {
	left = "0px",
	right = "0px",
	top = "0px",
	bottom = "0px",
}

-- and finally, return the configuration to wezterm
return config
