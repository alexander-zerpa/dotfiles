return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false, -- neo-tree will lazily load itself
    init = function()
        vim.keymap.set("n", "<leader>e", "<cmd>Neotree focus toggle<CR>", { desc = "Toggle NeoTree" })
        vim.keymap.set("n", "<leader>E", "<cmd>Neotree focus %<CR>", { desc = "Toggle NvimTree on current file" })
    end,
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
        filesystem = {
            window = {
                mappings = {
                    ["o"] = "open",
                    ["l"] = "open",
                    ["h"] = "close_node",
                },
            },
        },
    },
}
