require('barbar').setup({

})

vim.keymap.set('n', '<A-,>', ':BufferPrevious<CR>');
vim.keymap.set('n', '<A-.>', ':BufferNext<CR>');
vim.keymap.set('n', '<A-<>', ':BufferMovePrevious<CR>');
vim.keymap.set('n', '<A->>', ':BufferMoveNext<CR>');
vim.keymap.set('n', '<A-w>', ':BufferClose<CR>');
vim.keymap.set('n', '<A-S-w>', ':BufferRestore<CR>');
