return
{
    'jiangmiao/auto-pairs',
    config = function()
      vim.g.auto_pairs = {
        ['('] = ')',
        ['['] = ']',
        ['{'] = '}',
        ['"'] = '"',
        --["'"] = "'",
      }
    end,
    }
