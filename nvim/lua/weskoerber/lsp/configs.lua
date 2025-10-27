return {
    clangd = {},
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
        cmd = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'bin', 'OmniSharp'),
        settings = {
            ['RoslynExtensionsOptions'] = {
                ['enableDecompilationSupport'] = true,
            },
        },
    },
    rust_analyzer = {},
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
