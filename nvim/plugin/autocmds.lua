-- groups
local wk = vim.api.nvim_create_augroup('weskoerber', {})
local yank = vim.api.nvim_create_augroup('HighlightYank', {})

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    group = yank,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 75,
        })
    end,
})

-- Remove trailing whitespace
vim.api.nvim_create_autocmd('BufWritePre', {
    group = wk,
    pattern = '*',
    command = '%s/\\s\\+$//e',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'help', 'man' },
    command = 'winc L',
})
