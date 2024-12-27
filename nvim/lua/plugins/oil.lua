return {
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
            ['<c-p>'] = {
                callback = function()
                    require('oil').open_preview({ vertical = true, split = 'botright' })
                end
            },
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
