return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ft = 'markdown',
        opts = {
            render_modes = true,
            completions = {
                lsp = {
                    enable = true,
                },
            },
            code = {
                width = 'block',
                min_width = 80,
                language_border = ' ',
                language_left = '',
                language_right = '',
            },
            dash = {
                width = 80,
            },
            heading = {
                width = 'block',
                min_width = 80,
            },
        },
    },
    {
        "jmbuhr/otter.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = "markdown",
        init = function()
            vim.api.nvim_create_autocmd({ "BufRead", "InsertLeave" }, {
                group = vim.api.nvim_create_augroup("otter-autostart", {}),
                pattern = { "*.md" },
                callback = function()
                    require("otter").activate()
                end,
            })
        end,
        opts = {
            lsp = {
                diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
            },
        },
    },
}
