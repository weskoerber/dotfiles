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
        local utils = require('dap.utils')
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local get_exe_path_coro = function(opts)
            local find_opts = { 'fd', '--no-ignore' }

            for _, v in ipairs(opts) do
                table.insert(find_opts, v)
            end

            vim.print(find_opts);

            return coroutine.create(function(coro)
                local ts_opts = {}
                pickers
                    .new(ts_opts, {
                        prompt_title = "Path to executable",
                        finder = finders.new_oneshot_job(find_opts),
                        sorter = conf.generic_sorter(ts_opts),
                        initial_mode = 'normal',
                        attach_mappings = function(buffer_number)
                            actions.select_default:replace(function()
                                actions.close(buffer_number)
                                coroutine.resume(coro, action_state.get_selected_entry()[1])
                            end)
                            return true
                        end,
                    })
                    :find()
            end)
        end

        local get_pid_coro = function()
            return coroutine.create(function(coro)
                local opts = {}
                local procs = utils.get_processes({})
                pickers
                    .new(opts, {
                        prompt_title = "Running processes (user)",
                        finder = finders.new_table({
                            results = procs,
                            entry_maker = function(entry)
                                local formatted_entry = string.format('%8d | %s', entry.pid, entry.name)
                                return {
                                    value = entry,
                                    display = formatted_entry,
                                    ordinal = formatted_entry,
                                }
                            end,
                        }),
                        attach_mappings = function(prompt_bufnr, map)
                            actions.select_default:replace(function()
                                actions.close(prompt_bufnr)
                                local selection = action_state.get_selected_entry()
                                local pid = selection.value.pid

                                coroutine.resume(coro, pid)
                            end)
                            return true
                        end,
                        sorter = conf.generic_sorter(opts),
                    })
                    :find()
            end)
        end

        require('dap.ext.vscode').json_decode = require('json5').parse

        -- LLVM
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
                program = function()
                    return get_exe_path_coro({
                        '--type', 'executable',
                    })
                end,
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
                pid = get_pid_coro,
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
                program = function()
                    return get_exe_path_coro({
                        '--extension', 'dll',
                    })
                end,
            },
            {
                name = "Attach to process",
                type = "coreclr",
                request = "attach",
                cwd = '${workspaceFolder}',
                processId = get_pid_coro,
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
    end,
}
