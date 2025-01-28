return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- 'nvim-treesitter/nvim-treesitter', -- has its own plugin spec file, see lua/plugins/treesitter.lua
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
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
    config = function(opts)
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')

        telescope.load_extension('fzf')

        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    'Cargo.lock',
                },
                layout_strategy = 'flex',
                layout_config = {
                    flex = {
                        flip_columns = 120,
                    },
                },
                mappings = {
                },
            },
            pickers = {
                buffers = {
                    mappings = {
                        n = {
                            ['dd'] = actions.delete_buffer,
                        },
                        i = {
                            ['<M-d>'] = actions.delete_buffer,
                        },
                    },
                },
                git_branches = {
                    i = {
                        ['<M-d>'] = actions.git_delete_branch,
                    },
                    n = {
                        ['dd'] = actions.git_delete_branch,
                    },
                },
            },
        })

        -- files/buffers
        vim.keymap.set('n', '<leader>fa', function() builtin.live_grep() end)
        vim.keymap.set('n', '<leader>fb', function()
            builtin.buffers({
                sort_mru = true,
                sort_lastused = true,
                initial_mode = 'normal'
            })
        end)
        vim.keymap.set('n', '<leader>fd', function() builtin.find_files() end)
        vim.keymap.set('n', '<leader>ff', function() builtin.current_buffer_fuzzy_find() end)
        vim.keymap.set('n', '<leader>fo', function() builtin.oldfiles() end)

        -- git
        vim.keymap.set('n', '<leader>gb', function() builtin.git_branches() end)
        vim.keymap.set('n', '<leader>gc', function() builtin.git_commits() end)
        vim.keymap.set('n', '<leader>fg', function() builtin.git_files() end)
        vim.keymap.set('n', '<leader>gs', function() builtin.git_stash() end)

        -- lsp
        vim.keymap.set('n', '<leader>ld', function() builtin.diagnostics() end)
        vim.keymap.set('n', '<leader>li', function() builtin.lsp_implementations() end)
        vim.keymap.set('n', '<leader>ls', function() builtin.lsp_document_symbols() end)
        vim.keymap.set('n', '<leader>lu', function() builtin.lsp_incoming_calls() end)
        vim.keymap.set('n', '<leader>lw', function() builtin.lsp_dynamic_workspace_symbols() end)

        -- integration
        vim.keymap.set('n', '<leader>fm', function() builtin.man_pages({ sections = { 'ALL' } }) end)
        vim.keymap.set('n', '<leader>fh', function() builtin.help_tags() end)

        vim.keymap.set('n', '<C-space>', function() builtin.resume() end)
    end,
}
