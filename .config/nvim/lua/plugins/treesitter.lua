return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "windwp/nvim-ts-autotag",
        },
        config = function() 
            local configs = require("nvim-treesitter.configs")
            require("nvim-ts-autotag").setup()

            configs.setup({
                ensure_installed = "all",
                auto_install = false,
                highlight = { 
                    enable = true ,
                    additional_vim_regex_highlighting = true, -- for spellcheck
                },
                indent = { enable = true },  
            })

            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

            -- -- spell check
            -- vim.wo.spell = true
            -- vim.bo.spelloptions = "camel"
        end,
    },
    {
        "numToStr/Comment.nvim",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {},
        config = function()
            vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true , sp = "Grey" })
            vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underline = true , sp = "Grey" })
        end,
    }
}
