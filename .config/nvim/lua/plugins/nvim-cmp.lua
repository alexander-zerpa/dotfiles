return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-emoji",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            dependencies = {
                "rafamadriz/friendly-snippets",
            },
            keys = {
                { "<BS>", "<C-O>s", mode = { "s" } },
            },
        },
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",
        "windwp/nvim-autopairs",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")

        cmp.setup({
            preselect = cmp.PreselectMode.None,
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ['<CR>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        if luasnip.expandable() then
                            luasnip.expand()
                        else
                            cmp.confirm({
                                select = true,
                            })
                        end
                    else
                        fallback()
                    end
                end),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    -- elseif luasnip.locally_jumpable(1) then
                    --     luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    -- elseif luasnip.locally_jumpable(-1) then
                    --     luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    end
                end, { "i", "s" }),
                ["<C-S-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = 'luasnip' }, -- For luasnip users.
                { name = 'nvim_lsp' },
                { name = 'copilot' },
            }, {
                { name = 'calc' },
                { name = 'path' },
                { name = 'buffer' },
            }, {
                { name = 'emoji' },
            }),
            -- experimental = {
            --     native_menu = false,
            -- },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    local kind = lspkind.cmp_format({
                        -- mode = "symbol",
                        maxwidth = function()
                            return math.floor(0.45 * vim.o.columns)
                        end,
                        ellipsis_char = "...",
                        show_labelDetails = true,
                    })(entry, vim_item)

                    local strings = vim.split(kind.kind, "%s", { trimempty = true })
                    kind.kind = " " .. (strings[1] or "") .. " "
                    kind.menu = "    (" .. (strings[2] or "") .. ")"

                    if entry.source.name == "copilot" then
                        vim_item.kind = "  "
                        kind.menu = "    (Copilot)"
                    end

                    if entry.source.name == "calc" then
                        vim_item.kind = " 󰃬 "
                        kind.menu = "    (Calc)"
                    end

                    if entry.source.name == "emoji" then
                        vim_item.kind = " 󰞅 "
                        kind.menu = "    (Emoji)"
                    end

                    return kind
                end,
            }
        })
        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })
        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            }),
            matching = { disallow_symbol_nonprefix_matching = false }
        })
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        require("luasnip.loaders.from_vscode").lazy_load()
    end
}
