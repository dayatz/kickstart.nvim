return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup {
      ensure_installed = {
        'json',
        'javascript',
        'typescript',
        'tsx',
        'yaml',
        'html',
        'css',
        'markdown',
        'markdown_inline',
        'svelte',
        'graphql',
        'bash',
        'lua',
        'vim',
        'dockerfile',
        'gitignore',
        'python',
        'toml',
        'prisma',
        'vue',
        'go',
      },
      auto_install = true,
      prefer_git = true,
    }
  end,
}
