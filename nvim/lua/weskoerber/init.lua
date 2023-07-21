require('weskoerber.set')
require('weskoerber.remap')
require('weskoerber.lazy')

local augroup = vim.api.nvim_create_augroup
WesKoerberGroup = augroup('WesKoerber', {})

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

-- Format files with LSP
autocmd('BufWritePre', {
    group = WesKoerberGroup,
    pattern = '*.rs,*.go,*.cs,*.c,*.h,*.cpp,*.hpp,*.js,*.jsx,*.json,*.ts,*.tsx,*.php',
    command = 'lua vim.lsp.buf.format { async = true }'
})
