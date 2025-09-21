return {
    {
        "polirritmico/monokai-nightasty.nvim",
        lazy = false,
        priority = 1000,
        init = function()
            vim.o.background = "dark"
            vim.cmd.colorscheme("monokai-nightasty")
            -- vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { link = "WinSeparator" })
        end,
        opts = {},
    },
    {
        "nvim-tree/nvim-web-devicons",
        optional = true,
        dependencies = {
            "rachartier/tiny-devicons-auto-colors.nvim",
            event = "VeryLazy",
            opts = {},
        }
    }
}
