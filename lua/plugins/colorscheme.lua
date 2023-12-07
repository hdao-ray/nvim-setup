return  {
    'ghifarit53/tokyonight-vim',
    priority = 1000,
    config = function()
      vim.g.tokyonight_style = 'storm'
      vim.g.tokyonight_transparent_background = '0'
      vim.g.tokyonight_menu_selection_backgroun = 'green'
      vim.g.tokyonight_disable_italic_comment = 0
      vim.g.tokyonight_enable_italic = 1
      vim.g.tokyonight_cursor = 'red'
      vim.g.tokyonight_current_word = 'grey background'
      vim.cmd.colorscheme 'tokyonight'
    end
  }

  -- Theme inspired by Atom
    --'navarasu/onedark.nvim',
    --priority = 1000,
    --config = function()
     -- vim.cmd.colorscheme 'onedark'
    --end,