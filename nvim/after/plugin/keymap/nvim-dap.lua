local nnoremap = require('weskoerber.keymap').nnoremap
local dap = require('dap')

nnoremap('<F4>', dap.run_last)
nnoremap('<F5>', dap.continue)
nnoremap('<F10>', dap.step_over)
nnoremap('<F11>', dap.step_into)
nnoremap('<F12>', dap.step_out)
nnoremap('<C-b>b', dap.toggle_breakpoint)
nnoremap('<C-b>c', function() dap.set_breakpoint(vim.fn.input('Condition: ')) end)
nnoremap('<C-b>l', function() dap.set_breakpoint(nil, nil, vim.fn.input('Message: ')) end)
nnoremap('<C-b>r', dap.repl.open)
