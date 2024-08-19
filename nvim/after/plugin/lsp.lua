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
    -- 'csharp_ls', -- doesn't work right
    'cssls',
    'intelephense',
    'html',
    'htmx',
    'lua_ls',
    'rust_analyzer',
    'tsserver',
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
          vim.keymap.set('n', '<leader>gh', function() vim.cmd('vert sb | ClangdSwitchSourceHeader') end, opts);

          require('dap.ext.vscode').load_launchjs()
        end,
      })
    end,
    lua_ls = function()
      nvim_lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
    end,
  }
})

nvim_lspconfig.csharp_ls.setup({})
nvim_lspconfig.zls.setup({
  capabilities = lsp.get_capabilities(),
  on_new_config = function(new_config, new_root_dir)
    local zls_global_cfg = vim.fs.normalize('~/.config/zls.json')
    local zls_local_cfg = vim.fs.joinpath(new_root_dir, 'zls.json')
    local zls_cfg = vim.fn.filereadable(zls_local_cfg) == 1 and zls_local_cfg or zls_global_cfg

    new_config.cmd = { 'zls', '--config-path', zls_cfg }
  end,
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

vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { strikethrough = true })

-- Limit completions to 8 items at a time
vim.opt.pumheight = 8;

local cmp = require('cmp')
cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  formatting = {
    format = require('lspkind').cmp_format({
      mode = 'symbol_text',  -- show only symbol annotations
      maxwidth = 30,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        vim_item.menu = string.sub(vim_item.menu or '', 0, 50) .. '...'
        return vim_item
      end
    }),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    ['<C-j>'] = cmp.mapping.scroll_docs(4),
    ['<C-S-k>'] = cmp.mapping.scroll_docs(-1),
    ['<C-S-j>'] = cmp.mapping.scroll_docs(1),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-y>'] = cmp.mapping.confirm({ select = false }),
    ['<C-Space>'] = cmp.mapping.complete({}),
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
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

lsp.on_attach(function(_, bufnr)
  default_keymap(bufnr, false)
  lsp.buffer_autoformat()
  vim.api.nvim_create_user_command('InlayHintToggle',
    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, {})
end)


lsp.setup()

-- require('clangd_extensions').setup()

vim.diagnostic.config({
  virtual_text = true,
})
