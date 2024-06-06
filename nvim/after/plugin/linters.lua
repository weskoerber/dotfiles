local lint = require('lint')

-- LINTERS
lint.linters_by_ft = {
    php = { 'phpcs' },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufRead", "BufWritePost" }, {
    callback = function()
        lint.try_lint()
    end,
})

local lint_progress = function()
    local linters = lint.get_running()
    if #linters == 0 then
        return "󰦕"
    end
    return "󱉶 " .. table.concat(linters, ", ")
end

vim.api.nvim_create_user_command('LintInfo', function()
    print(lint_progress())
end, {})
