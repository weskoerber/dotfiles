local trouble = require('trouble')

vim.keymap.set('n', '<leader>dow', function() trouble.open('workspace_diagnostics') end)
vim.keymap.set('n', '<leader>dod', function() trouble.open('document_diagnostics') end)
