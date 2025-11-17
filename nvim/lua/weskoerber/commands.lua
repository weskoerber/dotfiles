local M = {
    setup = function() end,
}

local function trim_trailing_whitespace()
    local win = vim.api.nvim_get_current_win()
    local cur = vim.api.nvim_win_get_cursor(win)
    vim.cmd('%s/\\s\\+$//e')
    vim.api.nvim_win_set_cursor(win, cur)
end

local function highlight_yanked_text()
    vim.highlight.on_yank({
        higroup = 'IncSearch',
        timeout = 75,
    })
end

M.setup = function(opts)
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = opts.write_group,
        pattern = '*',
        callback = trim_trailing_whitespace,
    })

    vim.api.nvim_create_autocmd('TextYankPost', {
        group = opts.write_group,
        pattern = '*',
        callback = highlight_yanked_text,
    })
end

return M
