local lsp = require('lsp-zero')

lsp.preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

lsp.ensure_installed({
  'clangd',
  'csharp_ls',
  'intelephense',
  'rust_analyzer',
})

-- Fix undefined global 'vim'
lsp.nvim_workspace()

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I',
  },
})

local cmp = require('cmp')
lsp.setup_nvim_cmp({
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    ['<C-j>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        })
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
      c = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    }),
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
      cmp.config.compare.locality,
      cmp.config.compare.recently_used,
      cmp.config.compare.score,
      cmp.config.compare.offset,
      cmp.config.compare.order,
      cmp.config.compare.scope,
    },
  },
})

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

lsp.on_attach(function(client, bufnr)
  default_keymap(bufnr, false)
end)

lsp.configure('clangd', {
  on_attach = function(client, bufnr)
    local opts = {
      buffer = bufnr,
      remap = false,
    }

    default_keymap(bufnr, opts.remap)
    vim.keymap.set('n', '<leader>gh', function() vim.cmd('ClangdSwitchSourceHeader') end, opts);

    client.server_capabilities.semanticTokensProvider = nil
  end,
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})
