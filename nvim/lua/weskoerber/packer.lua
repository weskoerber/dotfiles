return require('packer').startup(function()
    -- Packer itself
    use('wbthomason/packer.nvim')

    -- Dependencies
    use('kyazdani42/nvim-web-devicons')
    use('nvim-lua/plenary.nvim')
    use('nvim-lua/popup.nvim')

    -- UI Plugins
    use('nvim-treesitter/nvim-treesitter', { run = function()
        require('nvim-treesitter.install').update({ with_sync = true })
    end })
    use('romgrk/nvim-treesitter-context')
    use('nvim-telescope/telescope.nvim', { requires = 'nvim-lua/plenary.nvim', tag = '0.1.x' })
    use('kyazdani42/nvim-tree.lua', { requires = 'nvim-web-devicons', tag = 'nightly' })
    use('lukas-reineke/indent-blankline.nvim')

    -- Git
    use('airblade/vim-gitgutter')

    -- LSP Plugins
    use('neovim/nvim-lspconfig')
    use('hrsh7th/nvim-cmp')
    use('onsails/lspkind-nvim')

    -- Snippet Engines
    use('l3mon4d3/luasnip')

    -- nvim-cmp completion sources
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-nvim-lua')

    -- Colorscheme
    use('gruvbox-community/gruvbox')

    -- Misc. Plugins
    use('sindrets/winshift.nvim')
    use('tpope/vim-sleuth') -- Heuristically set buffer opts

    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- Unused/uninstalled
    -- use('nvim-telescope/telescope-frecency.nvim', { requires = 'kkharji/sqlite.lua' })
