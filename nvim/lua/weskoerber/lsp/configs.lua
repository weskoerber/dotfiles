local util = require 'lspconfig.util'

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
        cmd = {
            vim.fn.resolve(
                vim.fs.joinpath(vim.fn.stdpath('data'),
                    'mason',
                    'bin',
                    'OmniSharp'
                )
            ),
            '-z', -- https://github.com/OmniSharp/omnisharp-vscode/pull/4300
            '--hostPID',
            tostring(vim.fn.getpid()),
            'DotNet:enablePackageRestore=false',
            '--encoding',
            'utf-8',
            '--languageserver',
        },
        filetypes = { 'cs', 'vb' },
        root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            on_dir(
                util.root_pattern '*.slnx' (fname)
                or util.root_pattern '*.sln' (fname)
                or util.root_pattern '*.csproj' (fname)
                or util.root_pattern 'omnisharp.json' (fname)
                or util.root_pattern 'function.json' (fname)
            )
        end,
        init_options = {},
        capabilities = {
            workspace = {
                workspaceFolders = false, -- https://github.com/OmniSharp/omnisharp-roslyn/issues/909
            },
        },
        on_attach = function(_)
            vim.print('attaching omnisharp')
            local oe = require('omnisharp_extended')
            vim.keymap.set('n', 'gd', oe.lsp_definition)
            vim.keymap.set('n', 'gt', oe.lsp_type_definition)
            vim.keymap.set('n', 'gr', oe.lsp_references)
            vim.keymap.set('n', 'gi', oe.lsp_implementation)
        end,
        settings = {
            FormattingOptions = {
                EnableEditorConfigSupport = true,
                OrganizeImports = true,
            },
            MsBuild = {
                -- If true, MSBuild project system will only load projects for files that
                -- were opened in the editor. This setting is useful for big C# codebases
                -- and allows for faster initialization of code navigation features only
                -- for projects that are relevant to code that is being edited. With this
                -- setting enabled OmniSharp may load fewer projects and may thus display
                -- incomplete reference lists for symbols.
                LoadProjectsOnDemand = nil,
            },
            RoslynExtensionsOptions = {
                -- Enables support for roslyn analyzers, code fixes and rulesets.
                EnableAnalyzersSupport = nil,
                -- Enables support for showing unimported types and unimported extension
                -- methods in completion lists. When committed, the appropriate using
                -- directive will be added at the top of the current file. This option can
                -- have a negative impact on initial completion responsiveness,
                -- particularly for the first few completion sessions after opening a
                -- solution.
                EnableImportCompletion = true,
                -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
                -- true
                AnalyzeOpenDocumentsOnly = nil,
                -- Enables the possibility to see the code in external nuget dependencies
                EnableDecompilationSupport = true,
            },
            RenameOptions = {
                RenameInComments = nil,
                RenameOverloads = nil,
                RenameInStrings = nil,
            },
            Sdk = {
                -- Specifies whether to include preview versions of the .NET SDK when
                -- determining which version to use for project loading.
                IncludePrereleases = true,
            },
        },
    },
    rust_analyzer = {
        settings = {
            ['rust_analyzer'] = {
                cargo = {
                    -- target = 'x86_64-unknown-linux-gnu',
                    target = 'x86_64-pc-windows-gnu',
                },
                check = {
                    command = { 'clippy' },
                },
            }
        },
    },
    ts_ls = {
        on_attach = function(client, bufnr)
            if default_cbs.ts_ls.on_attach then
                default_cbs.ts_ls.on_attach(client, bufnr)
            end
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
