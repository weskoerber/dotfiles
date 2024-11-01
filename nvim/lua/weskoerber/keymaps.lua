-- splits
vim.keymap.set('n', '<leader>gsv', function()
    vim.cmd.vsplit()
    vim.cmd.wincmd('l')
end);
vim.keymap.set('n', '<leader>gsh', function()
    vim.cmd.split()
    vim.cmd.wincmd('j')
end);
