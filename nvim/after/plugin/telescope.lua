require('telescope').load_extension('fzf')

require('telescope').setup({
    defaults = {
        color_devicons = true,
        prompt_prefix = ' > ',
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
            find_command = { "fd", "--hidden", "--glob", "--no-ignore-vcs", },
        },
        diagnostics = {
            bufnr = nil,
        },
    },
})

local builtin = require('telescope.builtin')

-- Find a file
vim.keymap.set('n', '<C-f>f', function()
    builtin.find_files()
end)

-- Find a line with the specified text
vim.keymap.set('n', '<C-f>a', function()
    builtin.live_grep()
end)

-- Find an exact word
vim.keymap.set('n', '<C-f>w', function()
    builtin.grep_string()
end)

-- Find git files
vim.keymap.set('n', '<C-f>g', function()
    builtin.git_files()
end)

-- Git commits
vim.keymap.set('n', '<leader>gl', function()
    builtin.git_commits()
end)

-- Git status
vim.keymap.set('n', '<leader>gs', function()
    builtin.git_status()
end)

-- Symbols
vim.keymap.set('n', '<C-f>s', function()
    builtin.lsp_document_symbols()
end)

vim.keymap.set('n', '<C-f>u', function()
    builtin.lsp_incoming_calls()
end)

vim.keymap.set('n', '<C-f>d', function()
    builtin.diagnostics()
end)