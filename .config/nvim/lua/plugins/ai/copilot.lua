return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        dependencies = {
            "AndreM222/copilot-lualine",
            {
                "saghen/blink.cmp",
                optional = true,
                dependencies = { "fang2hou/blink-copilot" },
                opts = {
                    sources = {
                        default = { "copilot" },
                        providers = {
                            copilot = {
                                name = "copilot",
                                module = "blink-copilot",
                                score_offset = 100,
                                async = true,
                            },
                        },
                    },
                },
            }
        },
        opts = {
            disable_limit_reached_message = true,
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },
}
