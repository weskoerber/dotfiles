local conform = require('conform')

local js_cfg = { 'prettier', stop_after_first = true }

conform.setup({
    format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
    },
    formatters_by_ft = {
        php = { 'php_cs_fixer' },

        javascript = js_cfg,
        javascriptreact = js_cfg,
        typescript = js_cfg,
        typescriptreact = js_cfg,
    },
    formatters = {
        php_cs_fixer = {
            command = vim.fn.resolve(vim.fs.joinpath('vendor', 'bin', 'php-cs-fixer')),
            args = { 'fix', '$FILENAME', '--quiet', '--config=.cs.php' },
        },
    },
})
