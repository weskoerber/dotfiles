-- plugin manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Auto-install lazy.nvim if not present
if not vim.uv.fs_stat(lazypath) then
    print('Installing lazy.nvim....')
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git', '--branch=stable', -- latest stable release
        lazypath,
    })
    print('Done.')
end

vim.opt.rtp:prepend(lazypath)

-- Plugins
require('lazy').setup({
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build =
                'cmake -S . -B build -D CMAKE_BUILD_TYPE=Release && cmake --build build && cmake --install build --prefix build',
            }
        }
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    },
    { 'nvim-treesitter/nvim-treesitter-context' },

    -- Json5
    {
        'Joakker/lua-json5',
        build = './install.sh',
    },

    -- UI Plugins
    { 'rktjmp/lush.nvim' },
    { "ellisonleao/gruvbox.nvim" },
    { 'Mofiqul/vscode.nvim' },
    {
        'catppuccin/nvim',
        name = 'catppuccin'
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
    },
    { 'savq/melange-nvim' },
    {
        'rose-pine/neovim',
        name = 'rose-pine'
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    { 'numToStr/Comment.nvim' },
    {
        'glepnir/dashboard-nvim',
        dependencies = { { 'nvim-tree/nvim-web-devicons' } },
        event = 'VimEnter',
    },
    { 'kyazdani42/nvim-tree.lua' },
    { 'nvim-lualine/lualine.nvim' },
    { 'akinsho/toggleterm.nvim' },

    -- Git
    { 'airblade/vim-gitgutter' },
    { 'f-person/git-blame.nvim' },
    { 'tpope/vim-fugitive' },

    -- Debuggers
    {
        'sakhnik/nvim-gdb',
        branch = 'devel'
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap' }
    },

    -- LSP Plugins
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'simrat39/rust-tools.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'L3MON4D3/LuaSnip' },
            -- { 'https://git.sr.ht/~p00f/clangd_extensions.nvim' },
        }
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- Misc
    { 'tpope/vim-sleuth' },
    { 'epwalsh/obsidian.nvim', branch = 'main' },
})
