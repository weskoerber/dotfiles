local opts = {
    -- The default augroup
    default_group = vim.api.nvim_create_augroup('weskoerber', {}),

    -- Group for commands that run on BufWrite*
    write_group = vim.api.nvim_create_augroup('weskoerber.write', {}),
}

require('weskoerber.options').setup(opts)
require('weskoerber.commands').setup(opts)
