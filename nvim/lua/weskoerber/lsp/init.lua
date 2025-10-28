local M = {}

---@class SetupOpts

M.setup = function(opts)
    _ = opts

    local configs = require('weskoerber.lsp.configs')

    vim.lsp.config('*', {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
    })

    for name, config in pairs(configs) do
        vim.lsp.config(name, config)
        vim.lsp.enable(name, true)
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
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references)
            vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition)
            vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float)
            vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
            vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end)
            vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end)
            vim.keymap.set('n', '[e',
                function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end)
            vim.keymap.set('n', ']e',
                function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end)

            if configs.on_attach then
                client:on_attach(bufnr)
            end
        end,
    })
end

return M
