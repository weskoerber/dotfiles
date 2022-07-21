require('treesitter-context').setup({
    enable = true,
    max_lines = 0,
    show_all_context = true,
    throttle = true,
    patterns = {
        default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
            'return',
        },
        javascript = {
            'const',
        },
    },
})

