local Remap = require('weskoerber.keymap')
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local lspconfig = require('lspconfig')

local function default_keymap(keymap)
    nnoremap('gd', function() vim.lsp.buf.definition() end)
    nnoremap('K', function() vim.lsp.buf.hover() end)
    nnoremap('<leader>vh', function() vim.lsp.buf.signature_help() end)
    nnoremap('<leader>vd', function() vim.diagnostic.open_float() end)
    nnoremap('<leader>vrn', function() vim.lsp.buf.rename() end)
    nnoremap('[d', function() vim.diagnostic.goto_next() end)
    nnoremap('[u', function() vim.diagnostic.goto_prev() end)
    nnoremap('<leader>vca', function() vim.lsp.buf.code_action() end)
end

local function extend_default_keymap(keymap)
    default_keymap()
    if keymap ~= nil then
        keymap()
    end
end

local function config(_config)
    return vim.tbl_deep_extend('force', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = default_keymap,
    }, _config or {})
end

lspconfig.ccls.setup(config({
    on_attach = extend_default_keymap(function()

    end),
    init_options = {
        cache = {
            directory = '/tmp/ccls-cache',
        },
    },
}));

-- lspconfig.clangd.setup(config({
--     on_attach = extend_default_keymap(function()
--         nnoremap('<leader>sh', ':ClangdSwitchSourceHeader<CR>')
--         nnoremap('<leader>cg', ':!cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -S . -B build<CR>')
--         nnoremap('<leader>cb', ':!cmake --build build<CR>')
--
--     end)
-- }))

-- lspconfig.csharp_ls.setup(config())
lspconfig.omnisharp.setup(config({
    cmd = { 'dotnet', '/opt/omnisharp-linux-x64-net6.0/OmniSharp.dll' },
    enable_editorconfig_support = true,
    enable_ms_build_load_projects_on_demand = false,
    enable_roslyn_analyzers = false,
    organize_imports_on_format = true,
    enable_import_completion = true,
    sdk_include_prereleases = false,
    analyze_open_documents_only = false,
}))

lspconfig.eslint.setup(config())

lspconfig.gopls.setup(config({
    cmd = { 'gopls', 'serve' },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}))

-- lspconfig.psalm.setup(config())
lspconfig.intelephense.setup(config({
    settings = {
        intelephense = {
            telemetry = {
                enabled = false,
            },
        }
    }
}))

lspconfig.rust_analyzer.setup(config({
    on_attach = extend_default_keymap(function()
        nnoremap('<leader>rr', ':RustRun<CR>')
        nnoremap('<leader>rb', ':!cargo check<CR>')
        nnoremap('<leader>rt', ':!cargo test<CR>')
    end),
}))

lspconfig.tsserver.setup(config())

lspconfig.yamlls.setup(config({
    settings = {
        schemas = {
            ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "ims-api.yml",
        },
    },
}))
