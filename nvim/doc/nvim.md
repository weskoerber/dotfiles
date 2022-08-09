# Neovim Configs

## Plugins Setup

1. Clone this repo into a Neovim configuration location (see `:help config` for valid locations)
2. Ensure [Packer](https://github.com/wbthomason/packer.nvim) is installed
    - `:PackerStatus` will show installed plugins
3. Run `:PackerSync`
4. Run `:healthcheck` to ensure proper setup

## LSP Setup

See the latest Neovim lspconfig server configurations
[here](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md).

The `lspconfig.lua` file contains a default `config` object that contains common configuration, such as keymaps. When
setting up language servers with the `setup()` function, pass the `config` object along with any other custom config:

```lua
-- Default config defined in the config object
lspconfig.your_lsp.setup(config())

-- Default config defined in the config object, along with custom_field
lspconfig.your_lsp.setup(config({ custom_field = 'some_value' }))
```

### [ccls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ccls)

1. [Build](https://github.com/MaskRay/ccls/wiki/Build) and [install](https://github.com/MaskRay/ccls/wiki/Install) ccls
2. Call the `setup` method in `lspconfig.lua` with your configuration

### [ESLint](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint)

1. Install ESLint with `vscode-langservers-extracted`
2. Call the `setup` method in `lspconfig.lua` with your configuration

### [Golang](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls)

1. Install `gopls`
2. Call the `setup` method in `lspconfig.lua` with your configuration

### [Omnisharp](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#omnisharp)

1. Download the latest [OmniSharp](https://github.com/OmniSharp/omnisharp-roslyn) release
2. Extract and modify the `cmd` field in the omnisharp lspconfig setup call in `lspconfig.lua`
3. Call the `setup` method in `lspconfig.lua` with your configuration

### [Psalm](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#psalm)

1. Install `psalm` with `composer`
2. Call the `setup` method in `lspconfig.lua` with your configuration

### [TSServer](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver) (Typescript Server)

1. Install typescript and the typescript language server
2. Call the `setup` method in `lspconfig.lua` with your configuration
