-- plugin manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Auto-install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
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
            {'nvim-lua/plenary.nvim'},
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S . -B build -D CMAKE_BUILD_TYPE=Release && cmake --build build && cmake --install build --prefix build',
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
    {'nvim-treesitter/nvim-treesitter-context'},

    -- UI Plugins
    {'gruvbox-community/gruvbox'},
    {'kyazdani42/nvim-tree.lua'},
    {'nvim-lualine/lualine.nvim'},

    -- Git
    {'airblade/vim-gitgutter'},
    {'f-person/git-blame.nvim'},
    {'tpope/vim-fugitive'},

    -- Debuggers
    {
        'sakhnik/nvim-gdb',
        branch = 'devel'
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {'mfussenegger/nvim-dap'}
    },

    -- LSP Plugins
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
                'williamboman/mason.nvim',
                build = function()
                  pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'hrsh7th/cmp-buffer'},     -- Required
            {'hrsh7th/cmp-path'},     -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    },

    -- Misc
    {'tpope/vim-sleuth'},
})


-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())


require('weskoerber')
