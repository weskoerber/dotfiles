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
            ['<c-p>'] = { callback = function() require('oil').open_preview({vertical = true, split = 'botright'}) end },
        },
        watch_for_changes = true,
    },
    keys = {
        { '<c-p>', '<cmd>Oil<cr>'}
    },
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
}
