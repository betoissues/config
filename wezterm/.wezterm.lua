-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font("Iosevka Nerd Font")
config.window_background_opacity = 0.97
config.font_size = 15
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

local dark_theme = wezterm.color.get_builtin_schemes()['Afterglow']
dark_theme.foreground = "#f0f0f0"
dark_theme.background = "#050505"

local light_theme = {
    background = "#F0F0F0",
    foreground = "#222222",

    cursor_bg = "#43436c",
    cursor_fg = "#43436c",
    cursor_border = "#43436c",

    selection_fg = "#43436c",
    selection_bg = "#9fb5c9",

    scrollbar_thumb = "#b5cbd2",
    split = "#b5cbd2",

    ansi = {
        "#545464",
        "#c84053",
        "#6f894e",
        "#77713f",
        "#4d699b",
        "#b35b79",
        "#597b75",
        "#1F1F28",
    },

    brights = {
        "#43436c",
        "#d7474b",
        "#6e915f",
        "#836f4a",
        "#6693bf",
        "#624c83",
        "#5e857a",
        "#8a8980",
    },

    indexed = {
        [16] = "#e98a00", -- extended color 1
        [17] = "#e82424", -- extended color 2
    },

    tab_bar = {
        background = "#e4d794",

        active_tab = {
            bg_color = "#b35b79",
            fg_color = "#f2ecbc",
        },

        inactive_tab = {
            bg_color = "#a6a69c",
            fg_color = "#f2ecbc",
        },

        inactive_tab_hover = {
            bg_color = "#9fb5c9",
            fg_color = "#43436c",
            italic = true,
        },

        new_tab = {
            bg_color = "#b35b79",
            fg_color = "#f2ecbc",
        },

        new_tab_hover = {
            bg_color = "#9fb5c9",
            fg_color = "#43436c",
            italic = true,
        },
    }
}



config.color_schemes = {
    ['Dark Theme'] = dark_theme,
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
    return 'Dark Theme'
  else
    return 'Kanagawa Light'
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())

return config
