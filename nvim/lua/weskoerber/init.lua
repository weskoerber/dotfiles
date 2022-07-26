local augroup = vim.api.nvim_create_augroup
WesKoerberGroup = augroup('WesKoerber', {})

require('weskoerber.indent-blankline')
require('weskoerber.nvim-tree')
require('weskoerber.packer')
require('weskoerber.set')
require('weskoerber.telescope')

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

-- Briefly highlight yanked text
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 75,
        })
    end,
})

-- Remove trailing whitespace
autocmd('BufWritePre', {
    group = WesKoerberGroup,
    pattern = '*',
    command = '%s/\\s\\+$//e',
})

-- Format JS code
autocmd('BufWritePre', {
    group = WesKoerberGroup,
    pattern = '*.js,*.jsx,*.json,*.ts,*.tsx',
    command = 'EslintFixAll',
})
autocmd('BufWritePre', {
    group = WesKoerberGroup,
    pattern = '*.js,*.jsx,*.json,*.ts,*.tsx',
    command = 'Neoformat',
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
