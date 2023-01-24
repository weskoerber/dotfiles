local augroup = vim.api.nvim_create_augroup
WesKoerberGroup = augroup('WesKoerber', {})

require('weskoerber.indent-blankline')
require('weskoerber.nvim-tree')
require('weskoerber.packer')
require('weskoerber.set')
require('weskoerber.telescope')
require('weskoerber.winshift')
require('weskoerber.lualine');

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

-- Format files with LSP
autocmd('BufWritePre', {
    group = WesKoerberGroup,
    pattern = '*.rs,*.go,*.cs,*.c,*.h,*.cpp,*.hpp,*.js,*.jsx,*.json,*.ts,*.tsx,*.php',
    command = 'lua vim.lsp.buf.format { async = true }'
})

-- Parse XAML, props files as XML
autocmd({ 'BufEnter', 'BufRead', }, {
    group = WesKoerberGroup,
    pattern = '*.axaml,*.xaml,*.props',
    command = 'lua vim.bo.filetype = \'xml\'',
})

-- Parse cake files as csharp
autocmd({ 'BufEnter', 'BufRead', }, {
    group = WesKoerberGroup,
    pattern = '*.cake',
    command = 'lua vim.bo.filetype = \'cs\'',
})
