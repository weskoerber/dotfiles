require('toggleterm').setup({
    open_mapping = '<C-\\>',
    shade_terminals = false,
})

local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({
    cmd = 'lazygit',
    direction = 'float',
    float_opts = {
        border = 'curved',
    },
})

vim.keymap.set('n', '<C-g>g', function() lazygit:toggle() end, { noremap = true, silent = true })
