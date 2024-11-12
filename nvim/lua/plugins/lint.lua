return {
    'mfussenegger/nvim-lint',
    event = 'VeryLazy',
    config = function()
        local lint = require('lint')

        lint.linters_by_ft = {
            php = { 'phpcs' },
        }

        vim.api.nvim_create_autocmd('BufWritePost', {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
