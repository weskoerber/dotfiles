return {
    event = 'VeryLazy',
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        columns = {
            'icon',
            'permissions',
            'size',
            'mtime',
        },
        keymaps = {
            ['<c-p>'] = { 'actions.preview', opts = { vertical = true, split = 'belowright' } },
            ['<c-s>'] = { 'actions.select', opts = { vertical = true } },
            ['<c-h>'] = { 'actions.select', opts = { horizontal = true, split = 'belowright' } },
            ['yp'] = {
                callback = function()
                    require('oil.actions').copy_entry_path.callback()
                    -- vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
                end,
            },
        },
        watch_for_changes = true,
    },
    keys = {
        { '<c-p>', '<cmd>Oil<cr>' }
    },
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
}
