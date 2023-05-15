require('nvim-tree').setup({
    renderer = {
        add_trailing = true,
        root_folder_label = false,
    },
    view = {
        adaptive_size = true,
        side = 'right',
    },
})

vim.keymap.set('n', '<C-p>', ':NvimTreeToggle<CR>')
