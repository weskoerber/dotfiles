local M = {
    setup = function(opts)
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = opts.write_group,
            pattern = '*',
            callback = function()
                local win = vim.api.nvim_get_current_win()
                local cur = vim.api.nvim_win_get_cursor(win)
                vim.cmd('%s/\\s\\+$//e')
                vim.api.nvim_win_set_cursor(win, cur)
            end,
        })
    end
}

return M
