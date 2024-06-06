-- This happens automatically?? At least, it is now...
-- require('dap.ext.vscode').load_launchjs()

local php_cs_fixer = vim.api.nvim_create_augroup('PHP CS Fixer', {})

local file_exists = function(filename)
    local f = io.open(filename, 'r')
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = { '*.php', },
    desc = 'Auto-format PHP source files with php-cs-fixer',
    callback = function()
        local file = vim.api.nvim_buf_get_name(0)
        local config = vim.fs.normalize(vim.fn.getcwd() .. '/.cs.php')
        local cmd = ':silent !php-cs-fixer fix --quiet '

        if file_exists(config) then
            cmd = cmd .. '--config=.cs.php '
        end

        vim.cmd(cmd .. file)
    end,
    group = php_cs_fixer,
})
