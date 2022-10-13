local nnoremap = require('weskoerber.keymap').nnoremap
local tscope = require('telescope')
local tscope_builtin = require('telescope.builtin')

-- Find a file using the frecency algo
-- nnoremap('<C-p>', function()
--     tscope.extensions.frecency.frecency()
-- end)

-- Find a file
nnoremap('<C-f>f', function()
    tscope_builtin.find_files()
end)

-- Find a line with the specified text
nnoremap('<C-f>a', function()
    tscope_builtin.grep_string({ search = vim.fn.input('Search everywhere > ') })
end)

-- Find an exact word
nnoremap('<C-f>w', function()
    tscope_builtin.grep_string({ search = vim.fn.expand('<cword>') })
end)

-- Find git files
nnoremap('<C-f>g', function()
    tscope_builtin.git_files()
end)

-- Git commits
nnoremap('<C-f>l', function()
    tscope_builtin.git_commits()
end)

-- Symbols
nnoremap('<C-f>s', function()
    tscope_builtin.lsp_document_symbols()
end)

