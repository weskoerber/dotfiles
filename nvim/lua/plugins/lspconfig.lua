return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },
        'stevearc/conform.nvim',
    },
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile', 'VeryLazy' },
    config = function()
        local lspconfig = require('lspconfig')

        local capabilities = nil
        if pcall(require, 'cmp_nvim_lsp') then
            capabilities = require('cmp_nvim_lsp').default_capabilities()
        else
            capabilities = vim.lsp.protocol.make_client_capabilities()
        end

        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        -- i don't think i need this if i specify the library
                        -- below
                        -- diagnostics = {
                        --     globals = { 'vim' },
                        -- },
                        runtime = {
                            version = 'LuaJIT',
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                            },
                        },
                    },
                },
            },
            zls = {
                manual_install = true,
            },
        }

        -- local servers_to_install = vim.tbl_filter(function(key)
        --     local t = servers[key]
        --     if type(t) == 'table' then
        --         return not t.manual_install
        --     else
        --         return t
        --     end
        -- end, vim.tbl_keys(servers))

        for name, config in pairs(servers) do
            config = vim.tbl_deep_extend('force', {}, { capabilities = capabilities }, config)
            lspconfig[name].setup(config)
        end

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, { buffer = 0 })
                vim.keymap.set('n', 'gt', function() vim.lsp.buf.type_definition() end, { buffer = 0 })
                vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, { buffer = 0 })
                vim.keymap.set('n', '<leader>vh', function() vim.lsp.buf.signature_help() end, { buffer = 0 })
                vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, { buffer = 0 })
                vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, { buffer = 0 })
                vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, { buffer = 0 })
                vim.keymap.set('n', '[u', function() vim.diagnostic.goto_prev() end, { buffer = 0 })
                vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, { buffer = 0 })
            end,
        })

        local conform = require('conform')
        conform.setup({
            formatters_by_ft = {
            },
        })

        require('lsp_lines').setup()
        vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
    end,
}
