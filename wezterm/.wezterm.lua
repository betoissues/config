-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font("Iosevka Nerd Font")
config.window_background_opacity = 0.95
config.font_size = 12
config.enable_tab_bar = false
config.send_composed_key_when_left_alt_is_pressed = true
config.font_rules = {
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font("Iosevka Nerd Font", {weight="ExtraBold", stretch="Normal", style="Normal"})
  },
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font("Iosevka Nerd Font", {weight="ExtraBold", stretch="Normal", style="Italic"})
  },
}

config.force_reverse_video_cursor = true

local dark_theme = wezterm.color.load_scheme(wezterm.home_dir .. "/.config/wezterm/colors/zenbones.toml")
dark_theme.background = "#050505"


config.color_schemes = {
    ['Dark Theme'] = dark_theme,
}

function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Dark Theme'
  else
    return 'Dark Theme'
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())

return config
