local builtin = require('telescope.builtin')
local telescope = require('telescope')
local actions = require('telescope.actions')

local trouble = require('trouble.providers.telescope')

telescope.load_extension('fzf')

telescope.setup({
    defaults = {
        color_devicons = true,
        layout_strategy = 'flex',
        layout_config = {
            flex = {
                flip_columns = 130,
            },
        },
        prompt_prefix = ' > ',
        mappings = {
            i = {
                ['<C-q>'] = trouble.smart_open_with_trouble,
            },
            n = {
                ['<C-q>'] = trouble.smart_open_with_trouble,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
    pickers = {
        find_files = {
            find_command = { "fd", "--type", "file", "--hidden", "--glob", "--no-ignore-vcs", },
        },
        git_files = {
            find_command = { "fd", "--type", "file", "--hidden", "--glob", },
        },
        live_grep = {
            find_command = { 'rg', },
        },
        diagnostics = {
            bufnr = nil,
        },
    },
})

-- Find a file
vim.keymap.set('n', '<C-f>f', function()
    builtin.find_files()
end)

-- Find a line with the specified text
vim.keymap.set('n', '<C-f>a', function()
    builtin.live_grep()
end)

-- Find git files
vim.keymap.set('n', '<C-f>g', function()
    builtin.git_files()
end)

-- Find man pages
vim.keymap.set('n', '<C-f>m', function()
    builtin.man_pages({ sections = { 'ALL' } })
end)

-- Find help pages
vim.keymap.set('n', '<C-f>h', function()
    builtin.help_tags()
end)

-- Git commits
vim.keymap.set('n', '<C-g>c', function()
    builtin.git_commits()
end)

-- Git branches
vim.keymap.set('n', '<C-g>b', function()
    builtin.git_branches()
end)

-- Git status
vim.keymap.set('n', '<C-g>s', function()
    builtin.git_stash()
end)

-- Symbols
vim.keymap.set('n', '<C-f>s', function()
    builtin.lsp_document_symbols()
end)

vim.keymap.set('n', '<C-f>w', function()
    builtin.lsp_dynamic_workspace_symbols()
end)

vim.keymap.set('n', '<C-f>i', function()
    builtin.lsp_implementations()
end)
vim.keymap.set('n', '<C-f>u', function()
    builtin.lsp_incoming_calls()
end)

vim.keymap.set('n', '<C-f>d', function()
    builtin.diagnostics()
end)

vim.keymap.set('n', '<C-f>b', function()
    builtin.buffers()
end)

vim.keymap.set('n', '<C-space>', function()
    builtin.resume()
end)
