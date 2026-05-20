return {
  'dmtrKovalenko/fff.nvim',
  build = function()
    require('fff.download').download_or_build_binary()
  end,
  opts = {
    keymaps = {
      move_up = { '<Up>', '<C-k>' },
      move_down = { '<Down>', '<C-j>' },
    },
  },
  keys = {
    {
      '<leader>ff',
      function()
        require('fff').find_files()
      end,
      desc = '[F]FF [F]ind files',
    },
    {
      '<leader>fg',
      function()
        require('fff').live_grep()
      end,
      desc = '[F]FF Live [G]rep',
    },
    {
      '<leader>fz',
      function()
        require('fff').live_grep { grep = { modes = { 'fuzzy', 'plain' } } }
      end,
      desc = '[F]FF Fu[Z]zy grep',
    },
    {
      '<leader>fc',
      function()
        require('fff').live_grep { query = vim.fn.expand '<cword>' }
      end,
      desc = '[F]FF Search [C]urrent word',
    },
    {
      '<leader>fr',
      function()
        require('fff').scan_files()
      end,
      desc = '[F]FF [R]escan files',
    },
  },
}
