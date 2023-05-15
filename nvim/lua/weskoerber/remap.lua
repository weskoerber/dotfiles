vim.g.mapleader = ' '

-- Buffer navigation
vim.keymap.set('n', '<leader>wj', ':winc j<CR>')
vim.keymap.set('n', '<leader>wk', ':winc k<CR>')
vim.keymap.set('n', '<leader>wh', ':winc h<CR>')
vim.keymap.set('n', '<leader>wl', ':winc l<CR>')

-- Tabs
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>')
vim.keymap.set('n', '<leader>td', ':tabclose<CR>')
vim.keymap.set('n', '<leader>th', ':tabprevious<CR>')
vim.keymap.set('n', '<leader>tl', ':tabnext<CR>')

-- Config
vim.keymap.set('n', '<leader><leader>s', function() vim.cmd('so') end)
