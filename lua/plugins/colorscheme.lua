return  {

   'rose-pine/neovim',
    name = 'rose-pine',
  config = function()
    vim.g.variant = 'auto'
    vim.g.dark_variant = 'main'
    vim.g.bold_vert_split = false
    vim.g.dim_nc_background = false
    vim.g.disable_background = false
    vim.g.disable_float_background = false
    vim.g.disable_italics = false

	--- @usage string hex value or named color from rosepinetheme.com/palette
    vim.g.groups = {
	background = 'base',
      	background_nc = '_experimental_nc',
	panel = 'surface',
	panel_nc = 'base',
	border = 'highlight_med',
	comment = 'muted',
	link = 'iris',
	punctuation = 'subtle',
	error = 'love',
	hint = 'iris',
	info = 'foam',
	warn = 'gold',

	headings = {
            h1 = 'iris',
            h2 = 'foam',
            h3 = 'rose',
            h4 = 'gold',
            h5 = 'pine',
            h6 = 'foam',
        }
		-- or set all headings at once
		-- headings = 'subtle'
    }

    vim.g.highlight_groups = {
		ColorColumn = { bg = 'rose' },

		-- Blend colours against the "base" background
		CursorLine = { bg = 'foam', blend = 10 },
		StatusLine = { fg = 'love', bg = 'love', blend = 10 },

		-- By default each group adds to the existing config.
		-- If you only want to set what is written in this config exactly,
		-- you can set the inherit option:
		Search = { bg = 'gold', inherit = false },
	}

    vim.cmd.colorscheme('rose-pine')
  end

  }

  -- Theme inspired by Atom
    --'navarasu/onedark.nvim',
    --priority = 1000,
    --config = function()
     -- vim.cmd.colorscheme 'onedark'
    --end,
--[[
    'ghifarit53/tokyonight-vim',
    priority = 1000,
    config = function()
      vim.g.tokyonight_style = 'night'
      vim.g.tokyonight_transparent_background = '0'
      vim.g.tokyonight_menu_selection_backgroun = 'green'
      vim.g.tokyonight_disable_italic_comment = 0
      vim.g.tokyonight_enable_italic = 1
      vim.g.tokyonight_cursor = 'red'
      vim.g.tokyonight_current_word = 'pink background'
      vim.cmd.colorscheme 'tokyonight'
  end
--]]
