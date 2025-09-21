return {
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {
                    registries = { "github:mason-org/mason-registry" },
                },
            },
            {
                "neovim/nvim-lspconfig",
                config = function()
                    vim.lsp.config("lua_ls", {
                        settings = {
                            Lua = {
                                diagnostics = { globals = { 'vim' }, },
                                workspace = { library = vim.api.nvim_get_runtime_file('', true) },
                            },
                        },
                    })

                    -- Create an autocommand group to prevent duplicate keymaps on reload
                    vim.api.nvim_create_augroup("Lsp_Keymaps", { clear = true })

                    -- Create the LspAttach autocommand
                    vim.api.nvim_create_autocmd("LspAttach", {
                        group = "Lsp_Keymaps",
                        callback = function(args)
                            -- Get the buffer number for the newly attached LSP client
                            local bufnr = args.buf

                            -- Set the keymaps for LSP actions on the specific buffer
                            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show information", buffer = bufnr })
                            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Jump to definition", buffer = bufnr })
                            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Jump to declaration", buffer = bufnr })
                            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "List implementations", buffer = bufnr })
                            vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { desc = "Jump to type definition", buffer = bufnr })
                            vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "List references", buffer = bufnr })
                            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Show signature information", buffer = bufnr })
                            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename all references", buffer = bufnr })
                            vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = "Rename all references", buffer = bufnr })
                            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Select code action", buffer = bufnr })
                            vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, { desc = "Select code action", buffer = bufnr })
                            vim.keymap.set({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end, { desc = "Format using LSP client", buffer = bufnr })
                            vim.keymap.set({ 'n', 'x' }, '<leader>gf', function() vim.lsp.buf.format({ async = true }) end, { desc = "Format using LSP client", buffer = bufnr })

                            -- Set keymaps for diagnostics
                            vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "Show diagnostic message", buffer = bufnr })
                            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic", buffer = bufnr })
                            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic", buffer = bufnr })
                        end,
                    })
                end,
            },
        },
        opts = {},
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        dependencies = {
            {
                "artemave/workspace-diagnostics.nvim",
                opts = {}
            },
        },
        event = "VeryLazy",
        priority = 1000,
        init = function()
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN]  = " ",
                        [vim.diagnostic.severity.INFO]  = "󰠠 ",
                        [vim.diagnostic.severity.HINT]  = " ",
                    },
                },
                virtual_text = false,
                underline = {
                    severity = {
                        vim.diagnostic.severity.ERROR,
                        vim.diagnostic.severity.WARN,
                    },
                },
                severity_sort = true,
            })
        end,
        opts = {
            hi = {
                background = "NonText",
            },
            options = {
                use_icons_from_diagnostic = true,
                set_arrow_to_diag_color = true,
            },
        },
    },
    {
        "soulis-1256/eagle.nvim",
        init = function()
            vim.o.mousemoveevent = true
        end,
        opts = {
            --override the default values found in config.lua
        }
    },
}
