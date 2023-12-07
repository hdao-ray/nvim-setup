return {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-buffer', 
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-omni',
      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    config = function()
        local cmp = require("cmp")
    
        local luasnip = require("luasnip")
    
        local lspkind = require("lspkind")
    
        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()
    
        cmp.setup({
          completion = {
            completeopt = "menu,menuone,preview,noselect",
          },
          snippet = { -- configure how nvim-cmp interacts with snippet engine
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
            ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
            ["<C-e>"] = cmp.mapping.abort(), -- close completion window
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
          }),
          -- sources for autocompletion
          sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" }, -- snippets
            { name = "buffer" }, -- text within current buffer
            { name = "path" }, -- file system paths
          },
          -- configure lspkind for vs-code like pictograms in completion menu
          formatting = {
            format = lspkind.cmp_format({
              maxwidth = 50,
              ellipsis_char = "...",
            }),
          },
        })

        cmp.setup.filetype("tex", {
            formatting = {
              -- nvim-cmp overrides the standard completion-menu formatting. We use
              -- a custom format function to preserve the format as provided by
              -- VimTeX's omni completion function:
              format = function(entry, vim_item)
                  vim_item.menu = ({
                    omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
                    buffer = "[Buffer]",
                    -- formatting for other sources
                    })[entry.source.name]
                  return vim_item
                end,
            },
            sources = {
              { name = "omni", trigger_characters = { "{", "\\" } },
              { name = "luasnip" },
              { name = 'buffer' }
              -- other sources
            },
          })
      end
    }