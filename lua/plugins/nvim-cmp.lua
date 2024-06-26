return {
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-buffer',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-omni',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ['<C-CR>'] = cmp.mapping.confirm({select = true}),
        --['<CR>'] = cmp.mapping.confirm({select = true}),
      }),
      sources = {
        { name = "nvim_lsp" },
        {name="omni"},
        { name = "luasnip"},
        { name = "buffer" },
        { name = "path" },
      },
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })

    cmp.setup.filetype("tex", {
      formatting = {
        format = function(entry, vim_item)
          vim_item.menu = ({
            omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
            buffer = "[Buffer]",
          })[entry.source.name]
          return vim_item
        end,
      },
      sources = {
       { name = "omni", trigger_characters = { "{", "\\" } },
        { name = "luasnip" },
        --{ name = 'buffer' },
      },
    })
  end,
}
