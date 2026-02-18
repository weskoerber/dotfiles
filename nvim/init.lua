-- Plugin installation
vim.pack.add({
    -- LSP
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    'https://github.com/stevearc/conform.nvim',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/j-hui/fidget.nvim',
    'https://github.com/Hoffs/omnisharp-extended-lsp.nvim',
    'https://github.com/mfussenegger/nvim-lint',

    -- Debugging
    'https://codeberg.org/mfussenegger/nvim-dap.git',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/nvim-neotest/nvim-nio',     -- dependency of nvim-dap-ui

    -- Files/buffers
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/stevearc/oil.nvim',

    -- Quality of life
    'https://github.com/kylechui/nvim-surround',
    'https://github.com/weskoerber/known-folders.nvim',

    -- Integrations
    'https://github.com/nvim-orgmode/orgmode',
    'https://github.com/nvim-orgmode/org-bullets.nvim',
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/lewis6991/gitsigns.nvim',
    -- 'https://github.com/airblade/vim-gitgutter',

    -- Eye candy
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/ellisonleao/gruvbox.nvim',
}, { confirm = false })

-- Custom configuration
require('weskoerber')
