local trouble = require('trouble')

vim.keymap.set('n', '<leader>vca', function() trouble.open('workspace_diagnostics') end)
vim.keymap.set('n', '<leader>vcd', function() trouble.open('document_diagnostics') end)
