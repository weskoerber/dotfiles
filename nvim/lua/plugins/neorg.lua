return {
    'nvim-neorg/neorg',
    build = ':Neorg sync-parsers',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    keys = {
        { '<leader>ni',      '<cmd>Neorg index<CR>', },
        { '<leader>nr',      '<cmd>Neorg return<CR>', },
        { '<localleader>nn', '<Plug>(neorg.dirman.new-note)', },
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
            ['core.completion'] = {
                config = {
                    engine = 'nvim-cmp',
                }
            },
            ['core.integrations.nvim-cmp'] = {},
        },
    },
}
