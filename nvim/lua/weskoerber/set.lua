vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. '/.local/share/nvim/undodir'

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.cmdheight = 1

vim.opt.updatetime = 50

vim.opt.shortmess:append('c')

vim.opt.colorcolumn = '80'

vim.opt.cursorline = true

vim.opt.mouse = 'nv'

-- vim.opt.conceallevel = 2

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99

vim.opt.listchars = {
    space = '·',
    tab = '⇥ ',
    eol = '⏎',
}
vim.opt.list = true

vim.keymap.set('n', 'gv', function()
    vim.cmd.vsplit()
    vim.lsp.buf.definition()
end)

vim.keymap.set('n', 'gx', function()
    vim.cmd.hsplit()
    vim.lsp.buf.definition()
end)
