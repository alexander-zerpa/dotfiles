return {
    {
        "seblyng/roslyn.nvim",
        ft = { "cs", "fsharp", "vb" },
        dependencies = {
            {
                "mason-org/mason.nvim",
                optional = true,
                opts_extend = {
                    registries = {
                        "github:Crashdummy/mason-registry",
                    },
                },
            }
        },
        init = function()
            local dap_ok, dap = pcall(require, "dap")
            if not dap_ok then
                return
            end
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
        end,
        opts = {
            -- your configuration comes here; leave empty for default settings
        },
    },
}
