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

        local lazy_update = {
            lazy_status.updates,
            cond = lazy_status.has_updates,
        }

        -- local function show_macro()
        --     local recording_register = vim.fn.reg_recording()
        --     if recording_register == '' then
        --         return ''
        --     else
        --         return 'recording @' .. recording_register
        --     end
        -- end

        local lsp_status = {
            'lsp_status',
            icon       = '󰌘',
            ignore_lsp = { 'copilot' },
        }
        local copilot = {
            'copilot',
            show_colors = true,
        }

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

        local diff = {
            'diff',
            source = diff_source
        }

        local location = {
            'location',
            padding = { left = 0, right = 1 },
        }

        local sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'selectioncount', 'branch', diff, 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { lazy_update },
            lualine_y = { lsp_status, copilot, 'filetype' },
            lualine_z = { 'progress', location },
        }

        local inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'progress', location },
            lualine_y = {},
            lualine_z = {}
        }

        opts.sections = sections
        opts.inactive_sections = inactive_sections

        opts.extensions = { "nvim-tree" }

        lualine.setup(opts)
    end,
}
