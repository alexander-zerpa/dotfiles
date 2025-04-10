return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "windwp/nvim-ts-autotag",
            {
                "m-demare/hlargs.nvim",
                opts = {}
            },
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
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            require('nvim-treesitter.configs').setup({
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                            ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                            ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
                            ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

                            ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
                            ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

                            ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                            ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

                            ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                            ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

                            ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
                            ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

                            ["ad"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
                            ["id"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

                            ["ao"] = { query = "@class.outer", desc = "Select outer part of a class" },
                            ["io"] = { query = "@class.inner", desc = "Select inner part of a class" },

                            ["ac"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
                            ["ic"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
                        },
                        -- -- You can choose the select mode (default is charwise 'v')
                        -- --
                        -- -- Can also be a function which gets passed a table with the keys
                        -- -- * query_string: eg '@function.inner'
                        -- -- * method: eg 'v' or 'o'
                        -- -- and should return the mode ('v', 'V', or '<c-v>') or a table
                        -- -- mapping query_strings to modes.
                        -- selection_modes = {
                        --     ['@parameter.outer'] = 'v', -- charwise
                        --     ['@function.outer'] = 'V', -- linewise
                        --     ['@class.outer'] = '<c-v>', -- blockwise
                        -- },
                        -- -- If you set this to `true` (default is `false`) then any textobject is
                        -- -- extended to include preceding or succeeding whitespace. Succeeding
                        -- -- whitespace has priority in order to act similarly to eg the built-in
                        -- -- `ap`.
                        -- --
                        -- -- Can also be a function which gets passed a table with the keys
                        -- -- * query_string: eg '@function.inner'
                        -- -- * selection_mode: eg 'v'
                        -- -- and should return true or false
                        -- include_surrounding_whitespace = true,
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>na"] = { query = "@parameter.inner", desc = "Swap parameters/argument with next" },
                            ["<leader>nd"] = { query = "@function.outer", desc = "Swap function with next" },
                        },
                        swap_previous = {
                            ["<leader>pa"] = { query = "@parameter.inner", desc = "Swap parameters/argument with prev" },
                            ["<leader>pd"] = { query = "@function.outer", desc = "Swap function with prev" },
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]a"] = { query = "@argument.outer", desc = "Next argument start" },
                            ["]f"] = { query = "@call.outer", desc = "Next function call start" },
                            ["]d"] = { query = "@function.outer", desc = "Next method/function def start" },
                            ["]o"] = { query = "@class.outer", desc = "Next class start" },
                            ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
                            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
                            ["]c"] = { query = "@comment.outer", desc = "Next comment start" },

                            -- -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                            -- -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                            -- ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                            -- ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                        },
                        goto_next_end = {
                            ["]A"] = { query = "@cargument.outer", desc = "Next argument end" },
                            ["]F"] = { query = "@call.outer", desc = "Next function call end" },
                            ["]D"] = { query = "@function.outer", desc = "Next method/function def end" },
                            ["]O"] = { query = "@class.outer", desc = "Next class end" },
                            ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
                            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                            ["]C"] = { query = "@comment.outer", desc = "Next comment end" },
                        },
                        goto_previous_start = {
                            ["[a"] = { query = "@cargument.outer", desc = "Prev argument start" },
                            ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
                            ["[d"] = { query = "@function.outer", desc = "Prev method/function def start" },
                            ["[o"] = { query = "@class.outer", desc = "Prev class start" },
                            ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
                            ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
                            ["[c"] = { query = "@comment.outer", desc = "Prev comment start" },
                        },
                        goto_previous_end = {
                            ["[A"] = { query = "@cargument.outer", desc = "Prev argument end" },
                            ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
                            ["[D"] = { query = "@function.outer", desc = "Prev method/function def end" },
                            ["[O"] = { query = "@class.outer", desc = "Prev class end" },
                            ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
                            ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
                            ["[C"] = { query = "@comment.outer", desc = "Prev comment end" },
                        },
                    },
                    lsp_interop = {
                        enable = true,
                        border = 'none',
                        floating_preview_opts = {},
                        peek_definition_code = {
                            ["<leader>dd"] = "@function.outer",
                            ["<leader>do"] = "@class.outer",
                        },
                    },
                },
            })
            local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

            -- Repeat movement with ; and ,
            -- ensure ; goes forward and , goes backward regardless of the last direction
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

            -- vim way: ; goes to the direction you were moving.
            -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
        end,
    }
}
