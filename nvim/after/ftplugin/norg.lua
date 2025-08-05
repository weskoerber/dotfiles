---Map Normal Local
---@param lhs string
---@param rhs string
local mnl = function(lhs, rhs)
    vim.keymap.set('n', lhs, rhs, { buffer = true })
end

mnl('<LocalLeader>nr', '<cmd>Neorg return<CR>')
mnl('<LocalLeader>td', '<Plug>(neorg.qol.todo-items.todo.task-done)');
mnl('<LocalLeader>tp', '<Plug>(neorg.qol.todo-items.todo.task-pending)');
mnl('<LocalLeader>tu', '<Plug>(neorg.qol.todo-items.todo.task-undone)');
mnl('<localleader>nn', '<Plug>(neorg.dirman.new-note)')
mnl('gd', '<Plug>(neorg.esupports.hop.hop-link)')
mnl('>>', '<Plug>(neorg.promo.promote.nested)')
mnl('<<', '<Plug>(neorg.promo.demote.nested)')
mnl('>.', '<Plug>(neorg.promo.promote)')
mnl('<,', '<Plug>(neorg.promo.demote)')
