-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"

config.font = wezterm.font_with_fallback({
	-- "JetBrains Mono",
	{ family = "JetBrainsMono Nerd Font" },
})

--[[ config.font = wezterm.font("JetBrains Mono", { weight = "Bold", scale = 0.7, stretch = "Normal", style = "Normal" }) ]]

config.font_size = 13

config.enable_tab_bar = false

config.window_decorations = "NONE"
config.window_background_opacity = 1
config.macos_window_background_blur = 10

config.line_height = 1.0

config.window_padding = {
	left = "0px",
	right = "0px",
	top = "0px",
	bottom = "0px",
}

default_cursor_style = "SteadyBar"

return config
