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
                    }
                }
            })
            vim.api.nvim_set_hl(0, "GitSignsChange", { link = "DiffChanged" })
        end,
    },
    -- {
    --     "polirritmico/monokai-nightasty.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("monokai-nightasty").load({
    --             color_headers = true,
    --             markdown_header_marks = true,
    --         })
    --     end,
    -- },
    {
        -- "catppuccin/nvim",
        -- priority = 1000,
        -- config = function()
        --     vim.cmd.colorscheme("catppuccin")
        -- end,
    },
}
