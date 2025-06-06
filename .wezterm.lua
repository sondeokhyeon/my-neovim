local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- ** only Windows OS Options **
-- current Domain
-- config.default_domain = "WSL:Ubuntu"

-- tab
config.enable_tab_bar = true

-- window deco
config.window_decorations = "RESIZE"

-- font size
config.font_size = 14
config.font = wezterm.font_with_fallback({
	{
		family = "JetBrains Mono",
		weight = "Regular",
		harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	},
})
-- config.font = wezterm.font("D2Coding Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" })
-- config.font = wezterm.font({ weight = "Medium", stretch = "Normal", style = "Normal" })

-- colorscheme
config.color_scheme = "Tokyo Night Day"

-- config.unix_domains = { {
-- 	name = "unix",
-- } }

-- config.default_gui_startup_args = { "connect", "unix" }

-- opacity
-- config.window_background_opacity = 0.5
-- config.macos_window_background_blur = 0.5

return config
