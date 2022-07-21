local nnoremap = require('weskoerber.keymap').nnoremap
local tscope = require('telescope')
local tscope_builtin = require('telescope.builtin')

-- Find a file using the frecency algo
nnoremap('<C-p>', function()
    tscope.extensions.frecency.frecency()
end)

-- Find a file
nnoremap('<leader>pf', function()
    tscope_builtin.find_files()
end)

-- Find a line with the specified text
nnoremap('<C-f>', function()
    tscope_builtin.grep_string({ search = vim.fn.input('Search everywhere > ') })
end)

-- Find an exact word
nnoremap('<leader>pw', function()
    tscope_builtin.grep_string({ search = vim.fn.expand('<cword>') })
end)

-- Find git files
nnoremap('<leader>pg', function()
    tscope_builtin.git_files()
end)
