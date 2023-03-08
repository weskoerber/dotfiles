local Remap = require('weskoerber.keymap')
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local source_map = {
    nvim_lsp = '[lsp] ',
    nvim_lua = '[nvim]',
    buffer = '[buff]',
    path = '[path]',
}

cmp.setup({
    enabled = function()
        -- disable completion in comments
        local ctx = require('cmp.config.context')
        if vim.api.nvim_get_mode().mode == 'c' then
            return true
        else
            return not ctx.in_treesitter_capture('comment') and not ctx.in_syntax_group('comment')
        end
    end,
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 75,
            before = function(entry, vim_item)
                vim_item.kind = lspkind.presets.codicons[vim_item.kind]
                if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= '' then
                    vim_item.menu = entry.completion_item.detail
                else
                    vim_item.menu = source_map[entry.source.name]
                end
                return vim_item
            end
        })
    },
    mapping = {
        ['<C-j>'] = cmp.mapping.scroll_docs(1),
        ['<C-k>'] = cmp.mapping.scroll_docs(-1),
        ['<C-d>'] = cmp.mapping.scroll_docs(8),
        ['<C-u>'] = cmp.mapping.scroll_docs(-8),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                    fallback()
                else
                    cmp.confirm()
                end
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        {
            name = 'nvim_lsp',
            entry_filter = function(entry, ctx)
                return cmp.lsp.CompletionItemKind.Text ~= entry:get_kind()
            end,
        },
        { name = 'nvim_lsp_signature_help', },
        { name = 'buffer' },
        { name = 'nvim_lua' },
        { name = 'path' },
    },
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
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
})
