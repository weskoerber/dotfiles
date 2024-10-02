local o = vim.opt

o.number = true
o.relativenumber = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

o.wrap = false

o.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. '/.local/share/nvim/undodir'

o.ignorecase = true
o.smartcase = true

o.signcolumn = 'yes'

o.listchars = {
    space = '·',
    tab = '⇥ ',
    eol = '⏎',
}
o.list = true
