return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile', 'VeryLazy' },
    lazy = vim.fn.argc(-1) == 0,
    opts = {
        ensure_installed = {
            'c',
            'cpp',
            'c_sharp',
            'rust',

            'bash',
            'javascript',
            'lua',
            'php',
            'phpdoc',
            'sql',

            'git_rebase',
            'gitattributes',
            'gitcommit',
            'gitignore',
            'git_config',

            'cmake',
            'make',

            'json',
            'jsonc',
            'markdown',
            'markdown_inline',
            'toml',
            'yaml',

            'comment',
            'diff',
            'http',
            'vim',
            'vimdoc',
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { 'markdown' },
        },
        indent = { enable = true },
        sync_install = false,
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
}
