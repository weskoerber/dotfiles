return {
    'nvim-neorg/neorg',
    build = ':Neorg sync-parsers',
    event = 'VeryLazy',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-neorg/neorg-telescope',
    },
    keys = {
        { '<leader>ni',  '<cmd>Neorg index<CR>', },
        { '<leader>nr',  '<cmd>Neorg return<CR>', },
        { '<leader>njn', '<cmd>Neorg journal today<CR>', },
        { '<leader>njj', '<cmd>Neorg journal custom<CR>', },
        { '<leader>njy', '<cmd>Neorg journal yesterday<CR>', },
        { '<leader>njt', '<cmd>Neorg journal tomorrow<CR>', },
        { '<leader>fn',  '<Plug>(neorg.telescope.find_norg_files)' },
        -- { '<localleader>nn', '<Plug>(neorg.dirman.new-note)', },
        -- { '<localleader>tc', '<Plug>(neorg.qol.todo-items.todo.task-cancelled)', },
        -- { '<localleader>td', '<Plug>(neorg.qol.todo-items.todo.task-done)', },
        -- { '<localleader>tp', '<Plug>(neorg.qol.todo-items.todo.task-pending)', },
        -- { '<localleader>tu', '<Plug>(neorg.qol.todo-items.todo.task-undone)', },
        -- { 'gd',              '<Plug>(neorg.esupports.hop.hop-link)' },
        -- { '>>',              '<Plug>(neorg.promo.promote.nested)' },
        -- { '<<',              '<Plug>(neorg.promo.demote.nested)' },
        -- { '>.',              '<Plug>(neorg.promo.promote)' },
        -- { '<,',              '<Plug>(neorg.promo.demote)' },
    },
    opts = {
        load = {
            ['core.defaults'] = {},
            ['core.keybinds'] = {
                config = {
                    default_keybinds = false,
                },
            },
            ['core.concealer'] = {
                config = {
                    icons = {
                        code_block = {
                            conceal = true,
                        },
                    },
                },
            },
            ['core.dirman'] = {
                config = {
                    index = 'index.norg',
                    default_workspace = 'acsd',
                    workspaces = {
                        acsd = '~/Documents/notes/acsd',
                        personal = '~/Documents/notes/personal',
                    },
                },
            },
            ['core.export'] = {},
            ['core.integrations.telescope'] = {},
        },
    },
}
