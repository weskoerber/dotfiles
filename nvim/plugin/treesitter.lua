require('tree-sitter-manager').setup({
    ensure_installed = {
        'c',
        'cpp',
        'c_sharp',
        'go',
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
})
