return {
    'tpope/vim-fugitive',
    keys = {
        {'<leader>gg', '<cmd>Git<cr>'},
    },
    config = function()
        vim.keymap.set('n', '<leader>gf', '<cmd>Git fetch<cr>')
        vim.keymap.set('n', '<leader>gy', '<cmd>Git push --force<cr>') -- yeet
        vim.keymap.set('n', '<leader>gY', '<cmd>Git push --force<cr>') -- YEET
    end,
}
