vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

-- splits
vim.keymap.set('n', '<leader>gsv', function()
    vim.cmd.vsplit()
    vim.cmd.wincmd('l')
end);
vim.keymap.set('n', '<leader>gsh', function()
    vim.cmd.split()
    vim.cmd.wincmd('j')
end);

-- Buffer navigation
vim.keymap.set('n', '<M-j>', ':winc j<CR>')
vim.keymap.set('n', '<M-k>', ':winc k<CR>')
vim.keymap.set('n', '<M-h>', ':winc h<CR>')
vim.keymap.set('n', '<M-l>', ':winc l<CR>')
