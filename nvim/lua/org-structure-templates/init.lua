local ts_utils = require('orgmode.utils.treesitter')

local M = {
    code_block = function()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local node = ts_utils.get_node_at_cursor(cursor)
        local item = ts_utils.closest_node(node, { 'body', 'paragraph', 'bullet', 'list', 'listitem', })

        if not item then
            vim.print('item is nil')
            return
        end

        local linenr = vim.fn.line('.') or 0
        local _, level = item:end_()
        vim.fn.append(linenr, {
            (' '):rep(level) .. ' #+BEGIN_SRC',
            (' '):rep(level) .. ' ',
            (' '):rep(level) .. ' #+END_SRC',
        })
        vim.fn.cursor(linenr + 2, level + 1)
        vim.cmd([[startinsert!]])
    end,
}

return M
