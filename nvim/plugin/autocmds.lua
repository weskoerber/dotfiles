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

-- Detect best foldexpr
vim.api.nvim_create_autocmd('FileType', {
    group = wk,
    callback = function()
        if require('nvim-treesitter.parsers').has_parser() then
            vim.opt.foldmethod = 'expr'
            vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            -- vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'
        else
            vim.opt.foldmethod = 'syntax'
        end
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = wk,
    callback = function()
        if #vim.lsp.get_clients() > 0 then
            vim.opt.foldmethod = 'expr'
            vim.opt.foldexpr = 'v:lua.vim.lsp.foldexpr()'
            -- vim.opt.foldtext = 'v:lua.vim.lsp.foldtext()'
        end
    end
})
