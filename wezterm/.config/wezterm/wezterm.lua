-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- For example, changing the color scheme:
config.color_scheme = "tokyonight"
-- config.font = wezterm.font("JetBrains Nerd Font Mono")
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Medium", stretch = "Normal", style = "Normal" }) -- (AKA: JetBrainsMono NFM, JetBrainsMono NFM Medium) /usr/share/fonts/JetBrainsMonoNerdFontMono-Medium.ttf, FontConfig
config.font_size = 22.0

-- and finally, return the configuration to wezterm
return config
