return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            {
                "nvim-telescope/telescope-live-grep-args.nvim",
                keys = {
                    {
                        "<leader>fg",
                        function() require("telescope").extensions.live_grep_args.live_grep_args() end,
                        desc = "Live grep",
                    },
                },
                config = function()
                    require("telescope").load_extension("live_grep_args")
                end,
            },
        },
        keys = {
            { "<leader>ff", require("telescope.builtin").find_files, desc = "Find files" },
            { "<leader>fb", require("telescope.builtin").buffers, desc = "List buffers" },
            { "<leader>fh", require("telescope.builtin").help_tags, desc = "List help tags" },
            { "<leader>fd", require("telescope.builtin").diagnostics, desc = "List diagnostics" },
        },
        opts = {},
    },
    {
        "tiagovla/scope.nvim",
        optinal = true,
        init = function()
            require("telescope").load_extension("scope")
        end,
    },
}
