local lsp = require('lsp-zero')
local mason = require('mason')
local lspconfig = require('mason-lspconfig')
local nvim_lspconfig = require('lspconfig')
local luasnip = require('luasnip')

mason.setup()

local mason_tools = {
  'cmake-language-server',
  'cpptools',
}

vim.api.nvim_create_user_command('MasonInstallAll', function()
  vim.cmd('MasonInstall ' .. table.concat(mason_tools))
end, {})

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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

nvim_lspconfig.gdscript.setup({})

lspconfig.setup({
  ensure_installed = {
    'clangd',
    'csharp_ls',
    'lua_ls',
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
          '--completion-style=detailed',
        },
        on_attach = function(client, bufnr)
          local opts = {
            buffer = bufnr,
            remap = false,
          }

          default_keymap(bufnr, opts.remap)
          vim.keymap.set('n', '<leader>gh', function() vim.cmd('ClangdSwitchSourceHeader') end, opts);

          require('dap.ext.vscode').load_launchjs()
        end,
      })
    end,
    lua_ls = function()
      nvim_lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
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
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  formatting = {
    format = require('lspkind').cmp_format({
      mode = 'symbol_text',  -- show only symbol annotations
      maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        return vim_item
      end
    })
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
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's', }
    ),
    ['<S-Tab>'] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's', }
    ),
  }),
  preselect = cmp.PreselectMode.Item,
  sorting = {
    priority_weight = 1.0,
    comparators = {
      cmp.config.compare.exact,
      cmp.config.compare.offset,
      cmp.config.compare.recently_used,
      cmp.config.compare.scopes,
      cmp.config.compare.score,
      -- require("clangd_extensions.cmp_scores"),
      cmp.config.compare.locality,
      cmp.config.compare.order,
    },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
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
