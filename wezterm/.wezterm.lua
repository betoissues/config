-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14
config.enable_tab_bar = false
config.send_composed_key_when_left_alt_is_pressed = true
config.font_rules = {
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font("JetBrainsMono Nerd Font", {weight="ExtraBold", stretch="Normal", style="Normal"}) 
  },
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font("JetBrainsMono Nerd Font", {weight="ExtraBold", stretch="Normal", style="Italic"})
  },
}

-- config.colors = {
--     background = "#0f0f0f",
--     foreground = "#f0f0f0",
--     cursor_fg = "#d8d8d8",
--     brights = {
--         "#585858",
--         "#ab4642",
--         "#a1b56c",
--         "#f7ca88",
--         "#7cafc2",
--         "#ba8baf",
--         "#86c1b9",
--         "#f8f8f8",
--     },
--     ansi = {
--         "#181818",
--         "#ab4642",
--         "#a1b56c",
--         "#f7ca88",
--         "#7cafc2",
--         "#ba8baf",
--         "#86c1b9",
--         "#d8d8d8",
--     },
-- }

config.color_scheme = 'Kanagawa Dragon (Gogh)'

local light_theme = wezterm.color.get_builtin_schemes()['Kanagawa Dragon (Gogh)']
light_theme.background = "#f0f0f0"
light_theme.foreground = "#2f2f2f"
light_theme.ansi = {
    "#1F1F28",
    "#c84053",
    "#6f894e",
    "#77713f",
    "#4d699b",
    "#b35b79",
    "#597b75",
    "#545464",
}

light_theme.brights = {
    "#8a8980",
    "#d7474b",
    "#6e915f",
    "#836f4a",
    "#6693bf",
    "#624c83",
    "#5e857a",
    "#43436c",
}


config.color_schemes = {
    ['Kanagawa Light'] = light_theme,
}

function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Kanagawa Dragon (Gogh)'
  else
    return 'Kanagawa Light'
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())

return config
