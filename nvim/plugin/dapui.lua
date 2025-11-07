local dapui = require('dapui')
local dap = require('dap')

dapui.setup({})

local is_open = false
local function toggle_ui()
    if is_open then
        dapui.close()
    else
        dapui.open()
    end

    is_open = not is_open
end

vim.api.nvim_create_user_command('DapuiToggle', toggle_ui, {})

vim.keymap.set('n', '<F17>', toggle_ui, {})
