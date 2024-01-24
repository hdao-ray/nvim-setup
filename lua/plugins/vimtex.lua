return {
    'lervag/vimtex',
    config = function()
    vim.g.compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        build_dir = '',
        continuous = 1,
        callback = 1,
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
      -- Set your preferred PDF viewer
     -- vim.fn.system('set PATH=C:\\PROGRA~1\\WindowsApps\\KDEe.V.Okular_23.801.1522.0_x64__7vt06qxq7ptv8\\bin; %PATH%')
      vim.g.vimtex_view_general_viewer = "C:\\Users\\raymo\\AppData\\Local\\SumatraPDF\\SumatraPDF.exe"
      vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'

    --vim.g.vimtex_view_general_viewer = "okular"
    --vim.g.vimtex_view_general_options_latexmk = '--unique'
--    vim.g.vimtex_view_general_viewer = "C:\\Users\\raymo\\Downloads\\mupdf-1.23.7-source\\mupdf-1.23.7-source\\platform\\win32\\x64\\Debug\\mupdf.exe"

     -- vim.g.vimtex_view_general_options = '--noraise --unique file:@pdf#src:@line@tex'

    end
}
