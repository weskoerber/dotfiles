vim.keymap.set("n", "<leader>Gf", function()
    vim.cmd("Git fetch")
end)

vim.keymap.set("n", "<leader>Gp", function()
    vim.cmd("Git pull")
end)

vim.keymap.set("n", "<leader>Gu", function()
    vim.cmd("Git push")
end)
