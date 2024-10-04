return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-buffer',
        { 'https://codeberg.org/FelipeLema/cmp-async-path' },
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lua',
        'onsails/lspkind.nvim',
    },
    opts = function()
        vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { strikethrough = true })

        local cmp = require('cmp')
        return {
            completion = {
                completeopt = 'menu,menuone,noinsert',
            },
            formatting = {
                format = require('lspkind').cmp_format({
                    mode = 'symbol_text',
                    maxwidth = 30,
                    ellipsis_char = '...',
                    before = function(entry, item)
                        item.menu = string.sub(item.menu or '', 0, 30)
                        if #item.menu >= 30 then
                            item.menu = item.menu .. '...'
                        end
                        return item
                    end
                }),
            },
            mapping = require('cmp').mapping.preset.insert({
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
            preselect = require('cmp').PreselectMode.Item,
            sorting = {
                priority_weight = 1.0,
                comparators = {
                    cmp.config.compare.exact,
                    cmp.config.compare.offset,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.scopes,
                    cmp.config.compare.score,
                    cmp.config.compare.locality,
                    cmp.config.compare.order,
                },
            },
            sources = {
                { name = 'async_path' },
                { name = 'buffer' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'nvim_lua', option = { include_deprecated = true } },
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        }
    end,
}
