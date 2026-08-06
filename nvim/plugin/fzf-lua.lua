local fzf = require('fzf-lua')
local fzf_cmd = require('fzf-lua.cmd')

vim.keymap.set('n', '<leader>fz', fzf_cmd.run_command)

vim.keymap.set('n', '<leader>fa', fzf.live_grep)

vim.keymap.set('n', '<leader>ff', fzf.files)

vim.keymap.set('n', '<leader>lf', fzf.lsp_document_symbols)
vim.keymap.set('n', '<leader>lw', fzf.lsp_workspace_symbols)
vim.keymap.set('n', '<leader>ld', fzf.lsp_document_diagnostics)
vim.keymap.set('n', '<leader>lp', fzf.lsp_workspace_diagnostics)
vim.keymap.set('n', '<leader>li', fzf.lsp_incoming_calls)

vim.keymap.set('n', '<leader>gb', fzf.git_branches)
vim.keymap.set('n', '<leader>gc', fzf.git_commits)
vim.keymap.set('n', '<leader>gf', fzf.git_files)

vim.keymap.set('n', '<leader>fb', fzf.buffers)
vim.keymap.set('n', '<leader>fj', fzf.marks)
vim.keymap.set('n', '<leader>fw', fzf.grep_cWORD)
vim.keymap.set('n', '<leader>ft', fzf.lgrep_curbuf)

vim.keymap.set('n', '<leader>fh', fzf.helptags)
vim.keymap.set('n', '<leader>fm', fzf.manpages)
