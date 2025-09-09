return {
    "nvim-tree/nvim-tree.lua",
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
        { "<leader>E", "<cmd>NvimTreeFindFile<cr>", desc = "Toggle NvimTree" },
    },
    opts = {
        hijack_cursor = true,
        select_prompts = true,

        view = {
            signcolumn = "auto",
        },

        renderer = {
            hidden_display = "all",
            highlight_git = "name",
            highlight_opened_files = "name",
            icons = {
                git_placement = "after",
                diagnostics_placement = "right_align",
            },
        },

        diagnostics = {
            enable = true,
            show_on_dirs = true,
        },

        modified = {
            enable = true,
        },

        on_attach = function(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- custom mappings
            vim.keymap.set('n', 'l',    api.node.open.edit,                 opts('Open'))
            vim.keymap.set('n', 'h',    api.node.navigate.parent_close,     opts('Close Directory'))
        end
    }
}
