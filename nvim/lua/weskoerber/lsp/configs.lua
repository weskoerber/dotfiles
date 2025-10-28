-- Save default config callbacks here
-- https://github.com/neovim/neovim/issues/33577#issuecomment-2832231240
local default_cbs = {
    ts_ls = {
        on_attach = vim.lsp.config.ts_ls.on_attach,
    },
}

return {
    clangd = {},
    intelephense = {},
    lua_ls = {
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                workspace = {
                    library = { vim.env.VIMRUNTIME },
                },
            },
        },
    },
    omnisharp = {
        -- NOTE: For some reason, specifying the command doesn't work
        -- cmd = {
        --     vim.fn.resolve(
        --         vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'bin', 'OmniSharp')
        --     ),
        -- },
        settings = {
            FormattingOptions = {
                EnabledEditorConfigSupport = true,
                OrganizeImports = true,
            },
            RoslynExtensionsOptions = {
                enableDecompilationSupport = true,
            }
        },
        on_attach = function(_)
            local oe = require('omnisharp_extended')
            vim.keymap.set('n', 'gd', oe.lsp_definition)
            vim.keymap.set('n', 'gt', oe.lsp_type_definition)
            vim.keymap.set('n', 'gr', oe.lsp_references)
            vim.keymap.set('n', 'gi', oe.lsp_implementation)
        end,
    },
    rust_analyzer = {},
    ts_ls = {
        on_attach = function(client, bufnr)
            if default_cbs.ts_ls.on_attach then
                default_cbs.ts_ls.on_attach(client, bufnr)
            end

            vim.api.nvim_create_autocmd('BufWritePre', {
                callback = function()
                    vim.lsp.buf.code_action({
                        apply = true,
                        context = {
                            only = {
                                'source.organizeImports',
                            },
                        }
                    })
                end
            })
        end,
    },
    zls = {
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
