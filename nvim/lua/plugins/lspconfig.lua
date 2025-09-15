return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
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

        vim.lsp.log.set_level('error')

        mason.setup()

        local servers = {
            bashls = {},
            clangd = {},
            intelephense = {},
            -- lemminx = {},
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
            html = {},
            ols = {},
            omnisharp = {
                cmd = {
                    vim.fs.normalize(
                        vim.fs.joinpath(
                            vim.fn.stdpath('data'),
                            'mason/bin/OmniSharp'
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
                        cargo = {
                            target = 'x86_64-unknown-linux-gnu',
                        },
                        check = {
                            command = { 'clippy' },
                        },
                    },
                },
            },
            ts_ls = {},
            zls = {
                manual_install = true,
                settings = {
                    -- https://github.com/zigtools/zls/blob/master/schema.json
                    enable_snippets = false,
                    enable_argument_placeholders = false,
                    completion_label_details = false,
                    enable_build_on_save = true,
                    build_on_save_args = {
                        '-fincremental',
                        'check',
                    },
                    semantic_tokens = 'full',
                    inlay_hints_show_variable_type_hints = false,
                    inlay_hints_show_struct_literal_field_type = false,
                    inlay_hints_show_parameter_name = false,
                    inlay_hints_show_builtin = false,
                    inlay_hints_exclude_single_argument = false,
                    inlay_hints_hide_redundant_param_names = false,
                    inlay_hints_hide_redundant_param_names_last_token = false,
                    force_autofix = false,
                    warn_style = true,
                    highlight_global_var_declarations = true,
                    skip_std_references = false,
                    prefer_ast_check_as_child_process = true,
                    builtin_path = nil,
                    zig_lib_path = nil,
                    zig_exe_path = nil,
                    build_runner_path = nil,
                    global_cache_path = nil,
                },
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
                vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = 1 }) end, { buffer = 0 })
                vim.keymap.set('n', '[u', function() vim.diagnostic.jump({ count = -1 }) end, { buffer = 0 })
                vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, { buffer = 0 })
                vim.keymap.set('n', '<leader>vcf',
                    function()
                        vim.lsp.buf.code_action({
                            context = {
                                only = {
                                    'source.fixAll',
                                },
                            },
                            apply = true,
                        })
                    end)

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
            notify_on_error = false,
            format_on_save = {
                timeout_ms = 30000, -- yuck; looking at you, zigfmt
                lsp_format = 'fallback',
                async = false,
            },
            formatters_by_ft = {
                c = { 'clang_format' },
                cpp = { 'clang_format' },
                php = { 'php_cs_fixer' },
                javascript = { 'prettier' },
                javascriptreact = { 'prettier' },
                typescript = { 'prettier' },
                typescriptreact = { 'prettier' },
                zig = { 'zigfmt' },
            },
            formatters = {
                php_cs_fixer = function()
                    return {
                        command = require('conform.util').find_executable({
                            'vendor/bin/php-cs-fixer',
                        }, 'php-cs-fixer'),
                        args = {
                            'fix',
                            '$FILENAME',
                            '--quiet',
                            '--config=.cs.php'
                        },
                    }
                end,
            },
        })

        require('lsp_lines').setup()
        vim.diagnostic.config({ virtual_text = true, virtual_lines = false })

        vim.keymap.set('n', '<leader>ll', function()
            local config = vim.diagnostic.config() or {}
            if config.virtual_text then
                vim.diagnostic.config { virtual_text = false, virtual_lines = true }
            else
                vim.diagnostic.config { virtual_text = true, virtual_lines = false }
            end
        end, { desc = 'Toggle lsp_lines' })

        vim.keymap.set('n', '<leader>lh', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end)
    end,
}
