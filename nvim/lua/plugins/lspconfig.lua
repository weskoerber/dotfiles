return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },
        'stevearc/conform.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile', 'VeryLazy' },
    config = function()
        local lspconfig = require('lspconfig')
        local mason = require('mason')
        local mason_registry = require('mason-registry')
        local mti = require('mason-tool-installer')
        local conform = require('conform')

        local capabilities = nil
        if pcall(require, 'cmp_nvim_lsp') then
            capabilities = require('cmp_nvim_lsp').default_capabilities()
        else
            capabilities = vim.lsp.protocol.make_client_capabilities()
        end

        local tools = {}

        mason.setup()

        local servers = {
            clangd = {},
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
            omnisharp = {
                cmd = {
                    vim.fs.normalize(
                        vim.fs.joinpath(
                            mason_registry.get_package('omnisharp'):get_install_path(),
                            'omnisharp'
                        )
                    )
                },
                server_capabilities = {
                    semanticTokensProvider = vim.NIL,
                },
                settings = {
                    FormattingOptions = {
                        EnableEditorConfigSupport = true,
                        OrganizeImports = true,
                    },
                    Sdk = {
                        IncludePrereleases = true,
                    },
                },
            },
            rust_analyzer = {
                settings = {
                    ['rust_analyzer'] = {
                        check = {
                            command = { 'clippy' },
                        },
                    },
                },
            },
            zls = {
                manual_install = true,
            },
        }

        local servers_to_install = vim.tbl_filter(function(key)
            local t = servers[key]
            if type(t) == 'table' then
                return not t.manual_install
            else
                return t
            end
        end, vim.tbl_keys(servers))

        local ensure_installed = {}
        vim.list_extend(ensure_installed, servers_to_install)
        vim.list_extend(ensure_installed, tools)

        mti.setup({ ensure_installed = ensure_installed })

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

                local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
                local settings = servers[client.name]

                if settings.server_capabilities then
                    for k, v in pairs(settings.server_capabilities) do
                        if v == vim.NIL then
                            ---@diagnostic disable-next-line: cast-local-type
                            v = nil
                        end

                        client.server_capabilities[k] = v
                    end
                end
            end,
        })

        conform.setup({
            format_on_save = {
                timeout_ms = 30000, -- yuck; looking at you, zigfmt
                lsp_format = 'fallback',
            },
            formatters_by_ft = {
                c = { 'clang_format' },
                cpp = { 'clang_format' },
                zig = { 'zigfmt' },
            },
        })

        require('lsp_lines').setup()
        vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
    end,
}
