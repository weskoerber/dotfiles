local Remap = require('weskoerber.keymap')
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local lspconfig = require('lspconfig')

local function config(_config)
    return vim.tbl_deep_extend('force', {
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function()
            nnoremap('gd', function() vim.lsp.buf.definition() end)
            nnoremap('K', function() vim.lsp.buf.hover() end)
            nnoremap('<leader>vh', function() vim.lsp.buf.signature_help() end)
            nnoremap('<leader>vd', function() vim.diagnostic.open_float() end)
            nnoremap('<leader>vrn', function() vim.lsp.buf.rename() end)
            nnoremap('[d', function() vim.diagnostic.goto_next() end)
            nnoremap('[u', function() vim.diagnostic.goto_prev() end)
            nnoremap('<leader>vca', function() vim.lsp.buf.code_action() end)
        end,
    }, _config or {})
end

lspconfig.ccls.setup(config({
    init_options = {
        cache = {
            directory = '.ccls-cache',
        },
    },
}));

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

lspconfig.psalm.setup(config())


lspconfig.tsserver.setup(config())
