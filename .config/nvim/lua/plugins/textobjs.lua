return {
    -- {
    --     "chrisgrieser/nvim-various-textobjs",
    --     event = "UIEnter",
    --     opts = { useDefaultKeymaps = true },
    -- },
    {
        'echasnovski/mini.ai',
        version = '*',
        opts = {},
        dependenci = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            local mini_ai = require('mini.ai')
            local gen_spec = mini_ai.gen_spec
            mini_ai.setup({
                custom_textonjects = {
                    a = gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
                    i = gen_spec.treesitter({ a = '@conditional.outer', i = '@conditional.inner' }),
                    l = gen_spec.treesitter({ a = '@loop.outer', i = '@loop.inner' }),
                    f = gen_spec.treesitter({ a = '@call.outer', i = '@call.inner' }),
                    d = gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
                    o = gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
                    c = gen_spec.treesitter({ a = '@comment.outer', i = '@comment.inner' }),
                },
                search_method = 'cover',
            })
        end,
    },
}
