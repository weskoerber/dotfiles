local configs = {
    zls = {},
}


for name, config in pairs(configs) do
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
end
