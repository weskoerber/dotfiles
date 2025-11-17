local M = {
    setup = function(opts)
        vim.g.mapleader = ' '

        -- Behavior
        vim.o.swapfile = false
        vim.o.wrap = false
        vim.o.ignorecase = true
        vim.o.smartcase = true
        vim.o.undofile = true

        -- Appearance
        vim.o.number = true
        vim.o.relativenumber = true
        vim.o.cursorline = true
        vim.o.signcolumn = 'yes'
        vim.cmd.colorscheme('gruvbox')
        vim.o.scrolloff = 10
        vim.o.hlsearch = false

        -- Not enough contrast with the 'Melange Dark' colorscheme, so disabled for now.
        vim.o.list = false
        vim.opt.listchars = {
            space = '·',
            tab = '⇥ ',
            eol = '⏎',
        }

        -- Tabs (if you forget how you set this up, see :h 30.5)
        vim.o.shiftwidth = 4
        vim.o.softtabstop = 4
        vim.o.expandtab = true

        -- cmdline
        vim.o.wildmode = 'noselect:lastused,full'
        vim.o.wildoptions = 'pum'
        vim.api.nvim_create_autocmd('CmdlineChanged', {
            callback = function() vim.fn.wildtrigger() end,
            group = opts.default_group,
        })
    end
}

return M
