require('gitsigns').setup({
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '-' },
        untracked = { text = '?' },
    },
})
