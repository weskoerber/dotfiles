return {
    'nvim-neorg/neorg',
    build = ':Neorg sync-parsers',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    keys = {
        { '<leader>ni',      '<cmd>Neorg index<CR>', },
        { '<leader>nr',      '<cmd>Neorg return<CR>', },
        { '<leader>njn',     '<cmd>Neorg journal today<CR>', },
        { '<leader>njj',     '<cmd>Neorg journal custom<CR>', },
        { '<leader>njy',     '<cmd>Neorg journal yesterday<CR>', },
        { '<leader>njt',     '<cmd>Neorg journal tomorrow<CR>', },
        { '<localleader>nn', '<Plug>(neorg.dirman.new-note)', },
        { '<localleader>tc', '<Plug>(neorg.qol.todo-items.todo.task-cancelled)', },
        { '<localleader>td', '<Plug>(neorg.qol.todo-items.todo.task-done)', },
        { '<localleader>tp', '<Plug>(neorg.qol.todo-items.todo.task-pending)', },
        { '<localleader>tu', '<Plug>(neorg.qol.todo-items.todo.task-undone)', },
        { 'gd',              '<Plug>(neorg.esupports.hop.hop-link)' },
        { '>>',              '<Plug>(neorg.promo.promote.nested)' },
        { '<<',              '<Plug>(neorg.promo.demote.nested)' },
        { '>.',              '<Plug>(neorg.promo.promote)' },
        { '<,',              '<Plug>(neorg.promo.demote)' },
    },
    opts = {
        load = {
            ['core.defaults'] = {},
            ['core.keybinds'] = {
                config = {
                    default_keybinds = false,
                },
            },
            ['core.concealer'] = {},
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
            -- ['core.completion'] = {
            --     config = {
            --         engine = 'nvim-cmp',
            --     }
            -- },
            ['core.export'] = {},
            -- ['core.integrations.nvim-cmp'] = {},
        },
    },
}
