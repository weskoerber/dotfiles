require('nvim-treesitter.configs').setup({
    ensure_installed = {
        -- Compiled Languages
        'c',
        'cpp',
        'c_sharp',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'rust',
        'zig',

        -- Scripting
        'awk',
        'bash',
        'css',
        'html',
        'javascript',
        'lua',
        'php',
        'phpdoc',
        'python',
        'regex',
        'scss',
        'sql',
        'typescript',

        -- VCS
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',

        -- Build Systems
        'cmake',
        'make',
        'meson',
        'ninja',

        -- Structured Text / Config Formats
        'ini',
        'json',
        'jsonc',
        'markdown',
        'markdown_inline',
        'toml',
        'yaml',

        -- Misc
        'comment',
        'diff',
        'help',
        'http',
        'vim',
    },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})
