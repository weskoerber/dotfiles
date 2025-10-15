require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'c', 'cpp', 'c_sharp', 'go', 'rust',
        'bash', 'javascript', 'lua', 'php', 'phpdoc', 'sql',
        'git_rebase', 'gitattributes', 'gitcommit', 'gitignore', 'git_config',
        'cmake', 'make',
        'json', 'jsonc', 'markdown', 'markdown_inline', 'toml', 'yaml',
        'comment', 'diff', 'http', 'vim', 'vimdoc',
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'markdown' },
    },
    indent = { enable = true },
    sync_install = false,
})
