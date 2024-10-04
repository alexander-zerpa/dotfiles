return {
    "nvim-lualine/lualine.nvim",
    even = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status")

        local opts = lualine.get_config()

        table.insert(opts.sections.lualine_x, 1, {
            lazy_status.updates,
            cond = lazy_status.has_updates,
        })

        lualine.setup(opts)
    end,
}
