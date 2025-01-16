local opt = vim.opt

opt.termguicolors = true
opt.conceallevel = 3

opt.number = true
opt.relativenumber = true
opt.cursorline = true
vim.cmd([[hi cursorline gui=none guifg=none guibg=none]])

opt.pumheight = 8

opt.errorbells = false

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. '/.local/share/nvim/undodir'

opt.hlsearch = false
opt.incsearch = true

opt.ignorecase = true
opt.smartcase = true

opt.scrolloff = 8
opt.textwidth = 80
opt.colorcolumn = '+0'
opt.signcolumn = 'yes'

opt.listchars = {
    space = '·',
    tab = '⇥ ',
    eol = '⏎',
}
opt.list = true

vim.filetype.add({
    extension = {
        wxs = 'xml',
    },
})
