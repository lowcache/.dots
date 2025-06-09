local wezterm = require("wezterm")
 -- A slightly altered version of catppucchin mocha
-- stylua: ignore
local mocha = {
   rosewater = '#f5e0dc',
   flamingo  = '#f2cdcd',
   pink      = '#f5c2e7',
   mauve     = '#cba6f7',
   red       = '#f38ba8',
   maroon    = '#eba0ac',
   peach     = '#fab387',
   yellow    = '#f9e2af',
   green     = '#a6e3a1',
   teal      = '#94e2d5',
   sky       = '#89dceb',
   sapphire  = '#74c7ec',
   blue      = '#89b4fa',
   lavender  = '#b4befe',
   text      = '#cdd6f4',
   subtext1  = '#bac2de',
   subtext0  = '#a6adc8',
   overlay2  = '#9399b2',
   overlay1  = '#7f849c',
   overlay0  = '#6c7086',
   surface2  = '#585b70',
   surface1  = '#45475a',
   surface0  = '#313244',
   base      = '#1f1f28',
   mantle    = '#181825',
   crust     = '#11111b',
   test      = 'rgba(0,0,0,0.2)',
}

local modmocha = {
   foreground = mocha.text,
   background = mocha.test,
   cursor_bg = mocha.rosewater,
   cursor_border = mocha.rosewater,
   cursor_fg = mocha.crust,
   selection_bg = mocha.surface2,
   selection_fg = mocha.text,
   ansi = {
      '#0C0C0C', -- black
      '#C50F1F', -- red
      '#13A10E', -- green
      '#C19C00', -- yellow
      '#0037DA', -- blue
      '#881798', -- magenta/purple
      '#3A96DD', -- cyan
      '#CCCCCC', -- white
   },
   brights = {
      '#767676', -- black
      '#E74856', -- red
      '#16C60C', -- green
      '#F9F1A5', -- yellow
      '#3B78FF', -- blue
      '#B4009E', -- magenta/purple
      '#61D6D6', -- cyan
      '#F2F2F2', -- white
   },
   tab_bar = {
      background = 'rgba(0, 0, 0, 0.4)',
      active_tab = {
         bg_color = mocha.surface2,
         fg_color = mocha.text,
      },
      inactive_tab = {
         bg_color = mocha.surface0,
         fg_color = mocha.subtext1,
      },
      inactive_tab_hover = {
         bg_color = mocha.surface0,
         fg_color = mocha.text,
      },
      new_tab = {
         bg_color = mocha.base,
         fg_color = mocha.text,
      },
      new_tab_hover = {
         bg_color = mocha.mantle,
         fg_color = mocha.text,
         italic = true,
      },
   },
   visual_bell = mocha.red,
   indexed = {
      [16] = mocha.peach,
      [17] = mocha.rosewater,
   },
   scrollbar_thumb = mocha.surface2,
   split = mocha.overlay0,
   compose_cursor = mocha.flamingo,
}

local modfrappe = {
   ansi = {
      '#bcc0cc',
      '#d20f39',
      '#40a02b',
      '#df8e1d',
      '#1e66f5',
      '#ea76cb',
      '#179299',
      '#5c5f77',
   },
   brights = {
      '#acb0be',
      '#d20f39',
      '#40a02b',
      '#df8e1d',
      '#1e66f5',
      '#ea76cb',
      '#179299',
      '#6c6f85',
   },
   compose_cursor = '#dd7878',
   cursor_bg = '#dc8a78',
   cursor_border = '#dc8a78',
   cursor_fg = '#dce0e8',
   foreground = '#4c4f69',
   scrollbar_thumb = '#acb0be',
   selection_bg = '#acb0be',
   selection_fg = '#4c4f69',
   split = '#9ca0b0',
   visual_bell = '#ccd0da',

   indexed = {
      [16] = '#fe640b',
      [17] = '#dc8a78',
   },
   tab_bar = {
      background = '#dce0e8',
      inactive_tab_edge = '#ccd0da',
   
      active_tab = {
         bg_color = '#8839ef',
         fg_color = '#dce0e8',
         intensity = 'Normal',
         italic = false,
         strikethrough = false,
         underline = 'None',
      },
      inactive_tab = {
         bg_color = '#e6e9ef',
         fg_color = '#4c4f69',
         intensity = 'Normal',
         italic = false,
         strikethrough = false,
         underline = 'None',
      },
      inactive_tab_hover = {
         bg_color = '#eff1f5',
         fg_color = '#4c4f69',
         intensity = 'Normal',
         italic = false,
         strikethrough = false,
         underline = 'None',
      },
      new_tab = {
         bg_color = '#ccd0da',
         fg_color = '#4c4f69',
         intensity = 'Normal',
         italic = false,
         strikethrough = false,
         underline = 'None',
      },
      new_tab_hover ={
         bg_color = '#bcc0cc',
         fg_color = '#4c4f69',
         intensity = 'Normal',
         italic = false,
         strikethrough = false,
         underline = 'None',
      },
   },
}

local modlsate = {
      ansi = {
      '#bcc0cc',
      '#d20f39',
      '#40a02b',
      '#df8e1d',
      '#1e66f5',
      '#ea76cb',
      '#179299',
      '#5c5f77',
   },
   brights = {
      '#acb0be',
      '#d20f39',
      '#40a02b',
      '#df8e1d',
      '#1e66f5',
      '#ea76cb',
      '#179299',
      '#6c6f85',
   },
   background = '#eff1f5',
   compose_cursor = '#dd7878',
   cursor_bg = '#dc8a78',
   cursor_border = '#dc8a78',
   cursor_fg = '#dce0e8',
   foreground = '#4c4f69',
   scrollbar_thumb = '#acb0be',
   selection_bg = '#acb0be',
   selection_fg = '#4c4f69',
   split = '#9ca0b0',
   visual_bell = '#ccd0da',

   indexed = {
      [16] = '#fe640b',
      [17] = '#dc8a78',
   },
   tab_bar = {
      background = '#dce0e8',
      inactive_tab_edge = '#ccd0da',
      active_tab = { 
         bg_color = '#8839ef',
         fg_color = '#dce0e8',
         intensity = 'Normal',
         italic = false,
         strikethrough = false,
         underline = 'None',
      },
      inactive_tab = {
         bg_color = '#e6e9ef',
         fg_color = '#4c4f69',
         intensity = 'Normal',
         italic = false,
         strikethrough = false,
         underline = 'None',
      },
      inactive_tab_hover = {
         bg_color = '#eff1f5',
         fg_color = '#4c4f69',
         intensity = 'Normal',
         italic = false,
         strikethrough = false,
         underline = 'None',
      },
      new_tab = {
         bg_color = '#ccd0da',
         fg_color = '#4c4f69',
         intensity = 'Normal',
         italic = false,
         strikethrough = false,
         underline = 'None',
      },
      new_tab_hover = {
         bg_color = '#bcc0cc',
         fg_color = '#4c4f69',
         intensity = 'Normal',
         italic = false,
         strikethrough = false,
         underline = 'None',
      },
   },
}

local catppuccin = { 
   moch = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"],
   mach = wezterm.color.get_builtin_schemes()["Catppuccin Macchiato"],
   frap = wezterm.color.get_builtin_schemes()["Catppuccin Frappe"],
   latte = wezterm.color.get_builtin_schemes()["Catppuccin Latte"],

}

return modlsate

