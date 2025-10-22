local orgst = require('org-structure-templates')

vim.opt.textwidth = 120
vim.opt.conceallevel = 3

vim.keymap.set('n', '<leader>osc', orgst.code_block, {})
