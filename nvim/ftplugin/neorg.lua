---Map Normal Local
---@param lhs string
---@param rhs string
local mnl = function(lhs, rhs)
    vim.keymap.set('n', lhs, rhs, { buffer = true })
end

mnl('<LocalLeader>tp', '<Plug>(neorg.qol.todo-items.todo.task-done)');
mnl('<LocalLeader>tp', '<Plug>(neorg.qol.todo-items.todo.task-pending)');
mnl('<LocalLeader>tu', '<Plug>(neorg.qol.todo-items.todo.task-undone)');
