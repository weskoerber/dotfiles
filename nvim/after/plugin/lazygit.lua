vim.api.nvim_create_user_command('Lazygit', function(opts)
    require('toggleterm.terminal').Terminal:new({
        cmd = 'lazygit',
        direction = 'float',
        float_opts = {
            border = 'curved',
        },
    }):toggle()
end, {})

vim.keymap.set('n', '<leader>gs', vim.cmd.Lazygit, {});
