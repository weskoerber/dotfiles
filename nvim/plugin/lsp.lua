local configs = {
    clangd = {},
    lua_ls = {
        settings = {
            Lua = {
                workspace = {
                    library = {
                        vim.env.VIMRUNTIME,
                    },
                },
            }
        },
    },
    rust_analyzer = {},
    zls = {},
}


for name, config in pairs(configs) do
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
end

vim.opt.completeopt = { 'menuone', 'noselect', 'popup', }
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.g.maplocalleader = ','

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        assert(client ~= nil, 'must have valid client')

        vim.lsp.completion.enable(true, client.id, bufnr, {
            autotrigger = true,
        })

        vim.keymap.set('n', 'K', vim.lsp.buf.hover)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
        vim.keymap.set('n', '<localleader>d', vim.diagnostic.open_float)
        vim.keymap.set('n', '<localleader>rn', vim.lsp.buf.rename)
    end,
})
