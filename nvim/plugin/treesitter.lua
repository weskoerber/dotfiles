require('nvim-treesitter').install({
    'c', 'cpp', 'c_sharp', 'go', 'rust',
    'bash', 'javascript', 'lua', 'php', 'phpdoc', 'sql',
    'git_rebase', 'gitattributes', 'gitcommit', 'gitignore', 'git_config',
    'cmake', 'make',
    'json', 'markdown', 'markdown_inline', 'toml', 'yaml',
    'comment', 'diff', 'http', 'vim', 'vimdoc',
})

vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        local bufnr = args.buf
        local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
        if not ok or not parser then
            return
        end

        vim.treesitter.start(bufnr)
    end,
});
