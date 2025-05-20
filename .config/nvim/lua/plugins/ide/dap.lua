return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        local mason_dap = require("mason-nvim-dap")

        mason_dap.setup()
        dapui.setup()

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        -- Create the dap keymaps
        vim.keymap.set('n', '<F5>',       dap.continue,  { desc = "dap continue" })
        vim.keymap.set('n', '<leader>dc', dap.continue,  { desc = "dap continue" })
        vim.keymap.set('n', '<F12>',      dap.restart,   { desc = "dap restart" })
        vim.keymap.set('n', '<leader>dr', dap.restart,   { desc = "dap restart" })
        vim.keymap.set('n', '<leader>dq', dap.terminate, { desc = "dap terminate" })

        vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "dap toggle breakpoint" })

        vim.keymap.set('n', '<F8>',       dap.step_back, { desc = "dap step back" })
        vim.keymap.set('n', '<leader>dS', dap.step_back, { desc = "dap step back" })
        vim.keymap.set('n', '<F9>',       dap.step_into, { desc = "dap step into" })
        vim.keymap.set('n', '<leader>di', dap.step_into, { desc = "dap step into" })
        vim.keymap.set('n', '<F10>',      dap.step_over, { desc = "dap step over" })
        vim.keymap.set('n', '<leader>ds', dap.step_over, { desc = "dap step over" })
        vim.keymap.set('n', '<F11>',      dap.step_out,  { desc = "dap step out" })
        vim.keymap.set('n', '<leader>do', dap.step_out,  { desc = "dap step out" })

        -- netcoredbg
        local netcoredbg = vim.fn.exepath "netcoredbg"
        if netcoredbg ~= "" then
            dap.adapters.coreclr = {
                type = 'executable',
                command = netcoredbg,
                args = { '--interpreter=vscode' }
            }
            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                    end,
                },
                {
                    type = "coreclr",
                    name = "attach - netcoredbg",
                    request = "attach",
                    processId = require('dap.utils').pick_process,
                },
            }
        end

        vim.fn.sign_define('DapBreakpoint',          { text = '󰯯 ', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '󰯲 ', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
        vim.fn.sign_define('DapLogPoint',            { text = '󰰍 ', texthl = 'DapLogPoint', linehl = '', numhl = '' })
        vim.fn.sign_define('DapStopped',             { text = '󰁖 ', texthl = 'DapStopped', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointRejected',  { text = '󰄰 ', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })
    end
}
