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

local dark_theme = wezterm.color.get_builtin_schemes()['Mellifluous']
dark_theme.foreground = "#f0f0f0"
dark_theme.background = "#111111"

local light_theme = {

background = "#ededed",
foreground = "#1a1a1a",
cursor_bg = "#bfad9e",
cursor_border = "#bfad9e",
cursor_fg = "#1a1a1a",
selection_bg = "#2d2d2d",
selection_fg = "#c0af8c",
ansi = {"#dadada","#d29393","#b3b393","#cbaa89","#a8a1be","#b39fb0","#c0af8c","#1a1a1a"},
brights = {"#ffffff","#c95954","#828040","#a6794c","#5a6599","#9c6995","#74a39e","#5b5b5b"},
}



config.color_schemes = {
    ['Mellifluous Dark'] = dark_theme,
    ['Mellifluous Light'] = light_theme,
}

function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Mellifluous Dark'
  else
    return 'Mellifluous Light'
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())

return config
