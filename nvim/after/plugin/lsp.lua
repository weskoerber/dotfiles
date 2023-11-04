local lsp = require('lsp-zero')
local mason = require('mason')
local lspconfig = require('mason-lspconfig')
local nvim_lspconfig = require('lspconfig')

mason.setup()

local mason_tools = {
  'cpptools',
}

vim.api.nvim_create_user_command('MasonInstallAll', function()
  vim.cmd('MasonInstall ' .. table.concat(mason_tools))
end, {})

local default_keymap = function(bufnr, remap)
  local opts = {
    buffer = bufnr,
    remap = remap,
  }

  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', '<leader>vh', function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set('n', '[u', function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
end

lsp.preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

lspconfig.setup({
  ensure_installed = {
    'clangd',
    'csharp_ls',
    'phpactor',
    'rust_analyzer',
    'zls',
  },
  handlers = {
    lsp.default_setup,
    clangd = function()
      nvim_lspconfig.clangd.setup({
        cmd = {
          'clangd',
          '--background-index',
          '--clang-tidy',
          '--completion-style=bundled',
        },
        on_attach = function(client, bufnr)
          local opts = {
            buffer = bufnr,
            remap = false,
          }

          default_keymap(bufnr, opts.remap)
          vim.keymap.set('n', '<leader>gh', function() vim.cmd('ClangdSwitchSourceHeader') end, opts);

          -- client.server_capabilities.semanticTokensProvider = nil

          require('dap.ext.vscode').load_launchjs()
        end,
      })
    end,
    lua_ls = function()
      lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())
    end,
  }
})

lsp.set_preferences({
  suggest_lsp_servers = false,
})

lsp.set_sign_icons({
  error = "",
  warning = "",
  hint = "",
  information = "",
  other = "",
})

local cmp = require('cmp')
cmp.setup({
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  }
})


cmp.setup({
  formatting = {
    -- changing the order of fields so the icon is the first
    fields = { 'menu', 'abbr', 'kind' },

    -- here is where the change happens
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
        nvim_lua = 'Π',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    ['<C-j>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end, { 'i', 's', }
    ),
    ['<S-Tab>'] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end, { 'i', 's', }
    ),
  }),
  sorting = {
    priority_weight = 1.0,
    comparators = {
      cmp.config.compare.exact,
      cmp.config.compare.offset,
      cmp.config.compare.recently_used,
      cmp.config.compare.scope,
      cmp.config.compare.score,
      -- require("clangd_extensions.cmp_scores"),
      cmp.config.compare.locality,
      cmp.config.compare.order,
    },
  },
})


lsp.on_attach(function(_, bufnr)
  default_keymap(bufnr, false)
  lsp.buffer_autoformat()
end)


lsp.setup()

-- require('clangd_extensions').setup()

local rust_lsp = lsp.build_options('rust_analyzer', {})
require('rust-tools').setup({ server = rust_lsp })

vim.diagnostic.config({
  virtual_text = true,
})
