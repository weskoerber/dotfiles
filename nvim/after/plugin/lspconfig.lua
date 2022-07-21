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
            nnoremap('<leader>vrn', function() vim.lsp.buf.rename() end)
            nnoremap('[d', function() vim.diagnostic.goto_next() end)
            nnoremap('[u', function() vim.diagnostic.goto_prev() end)
            nnoremap('<leader>vca', function() vim.lsp.buf.code_action() end)
        end,
    }, _config or {})
end

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
