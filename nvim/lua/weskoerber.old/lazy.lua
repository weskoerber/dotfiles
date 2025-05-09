local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    print('Installing lazy.nvim....')
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- -- Plugins
-- require('lazy').setup({
--     -- Telescope
--     {
--         'nvim-telescope/telescope.nvim',
--         dependencies = {
--             { 'nvim-lua/plenary.nvim' },
--             {
--                 'nvim-telescope/telescope-fzf-native.nvim',
--                 build =
--                 'cmake -S . -B build -D CMAKE_BUILD_TYPE=Release && cmake --build build && cmake --install build --prefix build',
--             }
--         }
--     },
--
--     -- Treesitter
--     {
--         'nvim-treesitter/nvim-treesitter',
--         build = function()
--             local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
--             ts_update()
--         end,
--     },
--     { 'nvim-treesitter/nvim-treesitter-context' },
--
--     -- Json5
--     {
--         'Joakker/lua-json5',
--         build = './install.sh',
--     },
--
--     -- UI Plugins
--     { "lukas-reineke/indent-blankline.nvim",    main = "ibl", opts = {} },
--     { "ellisonleao/gruvbox.nvim" },
--     { 'Mofiqul/vscode.nvim' },
--     {
--         "folke/todo-comments.nvim",
--         dependencies = { "nvim-lua/plenary.nvim" },
--     },
--     { 'numToStr/Comment.nvim' },
--     {
--         "kylechui/nvim-surround",
--         version = "*", -- Use for stability; omit to use `main` branch for the latest features
--         event = "VeryLazy",
--         config = function() require('nvim-surround').setup() end
--     },
--     { 'kyazdani42/nvim-tree.lua' },
--     { 'nvim-lualine/lualine.nvim' },
--     {
--         'romgrk/barbar.nvim',
--         dependencies = {
--             'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
--             'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
--         },
--         init = function() vim.g.barbar_auto_setup = false end,
--     },
--
--     -- Git
--     { 'tpope/vim-fugitive' },
--     { 'airblade/vim-gitgutter' },
--     { 'f-person/git-blame.nvim' },
--
--     -- Debuggers
--     {
--         'sakhnik/nvim-gdb',
--         branch = 'devel'
--     },
--     {
--         'rcarriga/nvim-dap-ui',
--         dependencies = {
--             'mfussenegger/nvim-dap',
--             'nvim-neotest/nvim-nio',
--             'theHamsta/nvim-dap-virtual-text',
--         }
--     },
--
--     -- LSP Plugins
--     {
--         'VonHeikemen/lsp-zero.nvim',
--         branch = 'v3.x',
--         dependencies = {
--             -- LSP Support
--             { 'neovim/nvim-lspconfig' },
--             { 'williamboman/mason.nvim' },
--             { 'williamboman/mason-lspconfig.nvim' },
--
--             -- Autocompletion
--             { 'hrsh7th/nvim-cmp' },
--             { 'hrsh7th/cmp-nvim-lsp' },
--             { 'hrsh7th/cmp-buffer' },
--             { 'hrsh7th/cmp-path' },
--             { 'hrsh7th/cmp-nvim-lsp-signature-help' },
--             {
--                 'L3MON4D3/LuaSnip',
--                 dependencies = {
--                     'saadparwaiz1/cmp_luasnip',
--                     'rafamadriz/friendly-snippets'
--                 },
--             },
--             -- { 'https://git.sr.ht/~p00f/clangd_extensions.nvim' },
--         }
--     },
--     { 'mfussenegger/nvim-lint' },
--     { 'onsails/lspkind.nvim' },
--     {
--         "folke/trouble.nvim",
--         dependencies = { "nvim-tree/nvim-web-devicons" },
--     },
--
--     -- Misc
--     { 'tpope/vim-sleuth' },
--     {
--         "nvim-neotest/neotest",
--         dependencies = {
--             "nvim-neotest/nvim-nio",
--             "nvim-lua/plenary.nvim",
--             "antoinemadec/FixCursorHold.nvim",
--             "nvim-treesitter/nvim-treesitter",
--             'rouge8/neotest-rust',
--             'lawrence-laz/neotest-zig',
--         }
--     },
-- })
