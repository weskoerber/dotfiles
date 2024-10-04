local utils = require('utils')

vim.api.nvim_create_user_command('FugitiveToggle', function()
    local found_buf = false

    for _, bufnr in pairs(vim.api.nvim_list_bufs()) do
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if vim.startswith(bufname, 'fugitive://') then
            found_buf = true
            vim.api.nvim_buf_delete(bufnr, {})
        end
    end

    if found_buf == false then
        vim.cmd([[Git]])
    end
end, {})

return {
    'tpope/vim-fugitive',
    keys = {
        {'<leader>gg', '<cmd>FugitiveToggle<cr>'},
    },
    config = function()
        vim.keymap.set('n', '<leader>gf', '<cmd>Git fetch<cr>')
        vim.keymap.set('n', '<leader>gy', '<cmd>Git push --force<cr>') -- yeet
        vim.keymap.set('n', '<leader>gY', '<cmd>Git push --force<cr>') -- YEET
    end,
}
