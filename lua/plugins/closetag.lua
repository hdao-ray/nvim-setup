return{
    'alvan/vim-closetag',
    config = function()
      vim.g.closetag_filenames = '*.html, *.xml, *.jsx'
      vim.g.closetag_filetypes = 'html, xml, jsx'
      vim.g.closetag_emptyTags_caseSensitive = 1
      vim.g.closetag_regions = {
        ['typescript.tsx'] = 'jsxRegion, tsxRegion',
        ["javascript.jsx"] = "jsxRegion",
        ["typescriptreact"] = "jsxRegion,tsxRegion",
        ["javascriptreact"] = "jsxRegion"
      }
      vim.g.closetag_shortcut = '>'
      vim.g.closetag_close_shortcut = '<leader>>'
    end
}
