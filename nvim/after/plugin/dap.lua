local dap = require('dap')

require('dap.ext.vscode').json_decode = require('json5').parse

-- C
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = vim.fs.normalize('~/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7'),
}

dap.configurations.c = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to C executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        args = {
        },
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to C++ executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        args = {
        },
    },

    {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
}

dap.configurations.zig = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to zig executable: ', vim.fn.getcwd() .. '/zig-out/bin/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        args = {
        },
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/zig-out/bin/', 'file')
        end,
    },
}

-- -- C#
dap.adapters.coreclr = {
    type = 'executable',
    command = os.getenv("HOME") .. '/.local/share/netcoredbg/netcoredbg',
    args = {
        '--interpreter=vscode',
    },
}

dap.configurations.cs = {
    {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
}

dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { '/usr/lib/node_modules/php-debug/out/phpDebug.js' },
}

vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F8>', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
