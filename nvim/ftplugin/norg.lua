local keys = {
    { '<localleader>nn', '<Plug>(neorg.dirman.new-note)', },
    { '<localleader>tc', '<Plug>(neorg.qol.todo-items.todo.task-cancelled)', },
    { '<localleader>td', '<Plug>(neorg.qol.todo-items.todo.task-done)', },
    { '<localleader>tp', '<Plug>(neorg.qol.todo-items.todo.task-pending)', },
    { '<localleader>tu', '<Plug>(neorg.qol.todo-items.todo.task-undone)', },
    { 'gd',              '<Plug>(neorg.esupports.hop.hop-link)' },
    { '>>',              '<Plug>(neorg.promo.promote.nested)' },
    { '<<',              '<Plug>(neorg.promo.demote.nested)' },
    { '>.',              '<Plug>(neorg.promo.promote)' },
    { '<,',              '<Plug>(neorg.promo.demote)' },
    { '<leader>fn',      '<Plug>(neorg.telescope.find_norg_files)' },
}

for _, v in ipairs(keys) do
    vim.keymap.set('n', v[1], v[2], { buffer = true })
end
