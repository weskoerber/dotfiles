-- Plugin installation
vim.pack.add({
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/savq/melange-nvim',
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/stevearc/conform.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/kylechui/nvim-surround',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
}, { confirm = false })

-- Vim Keybinds
vim.g.mapleader = ' '

-- Behavior
vim.o.swapfile = false
vim.o.wrap = false

-- Appearance
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = 'yes'
vim.cmd.colorscheme('melange')

-- Tabs (if you forget how you set this up, see :h 30.5)
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
