return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function(opts)
        local lualine = require("lualine")
        local lazy_status = require("lazy.status")

        local lazy_update = {
            lazy_status.updates,
            cond = lazy_status.has_updates,
        }

        local lsp_status = {
            'lsp_status',
            icon       = '󰌘',
            ignore_lsp = { 'copilot' },
        }
        local copilot = {
            'copilot',
            show_colors = true,
        }

        local diff = {
            'diff',
            source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                    return {
                        added = gitsigns.added,
                        modified = gitsigns.changed,
                        removed = gitsigns.removed
                    }
                end
            end
        }

        local branch = {
            "branch",
            fmt = function(str)
                if vim.api.nvim_strwidth(str) > 40 then
                    return ("%s…"):format(str:sub(1, 39))
                end

                return str
            end,
        }

        local location = {
            'location',
            padding = { left = 0, right = 1 },
        }

        opts.sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'selectioncount', branch, diff, 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { lazy_update },
            lualine_y = { lsp_status, copilot, 'filetype' },
            lualine_z = { 'progress', location },
        }
        opts.inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'progress', location },
            lualine_y = {},
            lualine_z = {}
        }

        opts.extensions = { "quickfix", "nvim-tree", "nvim-dap-ui", "neo-tree", "toggleterm", "trouble" }

        lualine.setup(opts)
    end,
}
