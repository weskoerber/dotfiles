return {
    'mfussenegger/nvim-dap',
    dependencies = {
        {
            'Joakker/lua-json5',
            build = './install.sh',
        },
    },
    keys = {
        { '<F5>',  '<cmd>DapContinue<CR>' },
        { '<F8>',  '<cmd>DapToggleBreakpoint<CR>' },
        { '<F10>', '<cmd>DapStepOver<CR>' },
        { '<F11>', '<cmd>DapStepInto<CR>' },
        { '<F12>', '<cmd>DapStepOut<CR>' },
    },
    config = function()
        local dap = require('dap')

        require('dap.ext.vscode').json_decode = require('json5').parse

        -- LLVM
        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = vim.fs.normalize(
                '~/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7'),
        }

        dap.adapters.lldb = {
            id = 'lldb',
            type = 'executable',
            name = 'lldb',
            command = '/usr/bin/lldb-dap'
        }

        local cfg_llvm = {
            {
                name = "Launch file",
                type = "lldb",
                request = "launch",
                MIMode = 'lldb',
                miDebuggerPath = '/usr/bin/lldb',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopAtEntry = true,
                args = {
                },
            }
        }

        dap.configurations.c = cfg_llvm
        dap.configurations.cpp = cfg_llvm
        dap.configurations.rust = cfg_llvm
        dap.configurations.zig = cfg_llvm

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
    end,
}
