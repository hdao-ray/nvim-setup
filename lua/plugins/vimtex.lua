return {
    'lervag/vimtex',
    config = function() 
      vim.g.vimtex_compiler_latexmk = {
        build_dir = '',
        executable = 'latexmk',
        options = {
          '-pdf',
          '-synctex=1',
          '-interaction=nonstopmode',
          '-file-line-error',
        },
      }
      vim.g.vimtex_enabled = 1
    
      vim.g.tex_flavor = 'latex'
    
      vim.cmd('set conceallevel=2')
    
      vim.g.tex_conceal = 'abdgms'
      
      vim.cmd('highlight Conceal guibg=Normal guifg=Normal ctermfg=None')
    
      vim.g.vimtex_imaps = 1
      vim.g.vimtex_imaps_enabled = 1
    
      vim.g.vimtex_autoclose = {'start', 'insert', 'item'}
    
    
      -- Set your preferred PDF viewer
      vim.g.vimtex_view_general_viewer = 'C:\\Users\\raymo\\AppData\\Local\\SumatraPDF\\SumatraPDF.exe'
      vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    end
}
