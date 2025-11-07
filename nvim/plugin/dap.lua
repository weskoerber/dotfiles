local dap = require('dap')

vim.keymap.set('n', '<F5>', '<cmd>DapContinue<CR>');
vim.keymap.set('n', '<F8>', '<cmd>DapToggleBreakpoint<CR>');
vim.keymap.set('n', '<F10>', '<cmd>DapStepOver<CR>');
vim.keymap.set('n', '<F11>', '<cmd>DapStepInto<CR>');
vim.keymap.set('n', '<F12>', '<cmd>DapStepOut<CR>');

local function get_program_path()
    return vim.fn.input('Path > ')
end

local function get_program_pid()
    return vim.fn.input('PID > ')
end

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = vim.fs.normalize(
        vim.fs.joinpath(
            vim.fn.stdpath('data'),
            '/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7'
        )
    ),
}

dap.adapters.lldb = {
    id = 'lldb',
    type = 'executable',
    name = 'lldb',
    command = '/usr/bin/lldb-dap'
}

-- TODO
local cfg_llvm = {
    {
        name = "Launch file",
        type = "lldb",
        request = "launch",
        MIMode = 'lldb',
        miDebuggerPath = '/usr/bin/lldb',
        args = function()
            return vim.split(vim.fn.input('Args: ') or '', ' ')
        end,
        program = get_program_path,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
    },
    {
        name = "Attach to process",
        type = "lldb",
        request = "attach",
        MIMode = 'lldb',
        miDebuggerPath = '/usr/bin/lldb',
        cwd = '${workspaceFolder}',
        pid = get_program_pid,
        stopAtEntry = true,
    }
}

dap.configurations.c = cfg_llvm
dap.configurations.cpp = cfg_llvm
dap.configurations.rust = cfg_llvm
dap.configurations.zig = cfg_llvm

-- -- C#
dap.adapters.coreclr = {
    type = 'executable',
    command = vim.fn.stdpath('data') .. '/mason/bin/netcoredbg',
    args = {
        '--interpreter=vscode',
    },
}

dap.configurations.cs = {
    {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = get_program_path,
    },
    {
        name = "Attach to process",
        type = "coreclr",
        request = "attach",
        cwd = '${workspaceFolder}',
        processId = get_program_pid,
        stopAtEntry = true,
    }
}

dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = {
        vim.fs.normalize(
            vim.fs.joinpath(
                vim.fn.stdpath('data'),
                'mason/packages/php-debug-adapter/extension/out/phpDebug.js'
            )
        )
    },
}
