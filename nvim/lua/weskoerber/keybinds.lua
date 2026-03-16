local quickfix_open = false

vim.keymap.set('n', 'qq', function()
    if quickfix_open then
        vim.cmd.cclose()
        quickfix_open = false
    else
        vim.cmd.copen()
        quickfix_open = true
    end
end)
