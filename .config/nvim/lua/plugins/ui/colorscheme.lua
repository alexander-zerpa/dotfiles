return {
    {
        "tanvirtin/monokai.nvim",
        priority = 1000,
        config = function()
            local monokai = require("monokai")
            local palette = monokai.classic

            monokai.setup({
                custom_hlgroups = {
                    DiffChanged = {
                        fg = palette.yellow,
                    },
                    Argument = {
                        fg = palette.orange,
                    },
                    Breakpoint = {
                        fg = palette.red,
                    },
                    DapStep = {
                        fg = palette.green,
                    },
                    DapRejected = {
                        fg = palette.grey,
                    },
                }
            })
            vim.api.nvim_set_hl(0, "GitSignsChange", { link = "DiffChanged" })
            vim.api.nvim_set_hl(0, "Hlargs", { link = "Argument" })

            vim.api.nvim_set_hl(0, "DapBreakpoint", { link = "Breakpoint" })
            vim.api.nvim_set_hl(0, "DapBreakpointCondition", { link = "Breakpoint" })
            vim.api.nvim_set_hl(0, "DapLogPoint", { link = "Breakpoint" })
            vim.api.nvim_set_hl(0, "DapStopped", { link = "DapStep" })
            vim.api.nvim_set_hl(0, "DapBreakpointRejected", { link = "DapRejected" })
        end,
    },
    -- {
    --     "polirritmico/monokai-nightasty.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     init = function()
    --         vim.o.background = "dark"
    --         vim.cmd.colorscheme("monokai-nightasty")
    --         -- vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { link = "WinSeparator" })
    --     end,
    --     opts = {
    --     },
    -- },
}
