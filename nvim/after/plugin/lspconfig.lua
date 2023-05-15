local Remap = require('weskoerber.keymap')
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local lspconfig = require('lspconfig')

local function default_keymap()
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

lspconfig.csharp_ls.setup(config({
    on_attach = function(client)
        default_keymap()
        client.server_capabilities.semanticTokensProvider = nil
    end
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
