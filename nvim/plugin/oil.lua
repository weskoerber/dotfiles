local oil = require('oil')

oil.setup({
    keymaps = {
        ['gq'] = { 'actions.close', mode = 'n' },
    },
    view_options = {
        show_hidden = true,
    },
})

vim.keymap.set('n', '<leader>e', oil.open)
