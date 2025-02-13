return {
    "nvim-lualine/lualine.nvim",
    even = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "AndreM222/copilot-lualine",
    },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status")

        local opts = lualine.get_config()

        table.insert(opts.sections.lualine_x, 1, {
            lazy_status.updates,
            cond = lazy_status.has_updates,
        })

        table.insert(opts.sections.lualine_x, 1, {
            'copilot',
            show_colors = true,
        })

        local function diff_source()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
                return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed
                }
            end
        end

        for key, value in pairs(opts.sections.lualine_b) do
            if value == 'diff' then
                opts.sections.lualine_b[key] = { 'diff', source = diff_source }
            end
        end

        opts.extensions = { "nvim-tree" }

        lualine.setup(opts)
    end,
}
