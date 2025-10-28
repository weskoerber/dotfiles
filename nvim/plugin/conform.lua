local conform = require('conform')
conform.setup({
    format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
    },
    formatters_by_ft = {
        php = { 'php_cs_fixer' },
    },
    formatters = {
        php_cs_fixer = {
            command = vim.fn.resolve(vim.fs.joinpath('vendor', 'bin', 'php-cs-fixer')),
            args = { 'fix', '$FILENAME', '--quiet', '--config=.cs.php' },
        },
    },
})
