local M = {
    setup = function(opts)
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = opts.write_group,
            pattern = '*',
            command = '%s/\\s\\+$//e',
        })
    end
}

return M
