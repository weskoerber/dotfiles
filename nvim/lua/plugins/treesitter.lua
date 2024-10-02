return {
    'nvim-treesitter/nvim-treesitter',
    config = function()
        local configs = require('nvim-treesitter.configs')

        configs.setup({
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
            sync_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'markdown' },
            },
            indent = { enable = true },
        })
    end,
}
