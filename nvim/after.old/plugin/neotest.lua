local neotest = require('neotest')

neotest.setup({
    adapters = {
        require('neotest-rust') {
            -- args = { '--no-capture' },
            dap_adapter = 'lldb',
        },
        require('neotest-zig') {
            -- args = { '--no-capture' },
            dap = {
                adapter = 'lldb',
            },
        },
    },
})

vim.keymap.set('n', '<leader>no', neotest.output_panel.toggle)
vim.keymap.set('n', '<leader>ns', neotest.summary.toggle)
vim.keymap.set('n', '<leader>nr', neotest.run.run)
vim.keymap.set('n', '<leader>na', function() neotest.run.run(vim.fn.expand('%')) end)
vim.keymap.set('n', '<leader>nK', neotest.output.open)

vim.keymap.set('n', '<leader>nj', neotest.jump.next)
vim.keymap.set('n', '<leader>nk', neotest.jump.prev)
vim.keymap.set('n', '<leader>nfj', function() neotest.jump.next({ status = 'failed' }) end)
vim.keymap.set('n', '<leader>nfk', function() neotest.jump.prev({ status = 'failed' }) end)
