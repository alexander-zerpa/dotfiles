return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        mason_lspconfig.setup()

        local border = "rounded"

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                },
                border = border,
            }
        })

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        vim.diagnostic.config({
            virtual_text = {
                severity = vim.diagnostic.severity.ERROR
                -- -- for 1.0.0
                -- prefix = function(diagnostic)
                --     if diagnostic.severity == vim.diagnostic.severity.ERROR then
                --         return signs['Error']
                --     elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                --         return signs['Warn']
                --     elseif diagnostic.severity == vim.diagnostic.severity.HINT then
                --         return signs['Hint']
                --     elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                --         return signs['Info']
                --     end
                -- end,
            },
            underline = {
                severity = vim.diagnostic.severity.ERROR
            },
            severity_sort = true,
        })

        -- Create the lsp keymaps only when a
        -- language server is active
        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf }
                -- recommended
                opts.desc = "show information"
                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                opts.desc = "jumps to definition"
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                opts.desc = "jumps to declaration"
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                opts.desc = "list implementations"
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                opts.desc = "jumps to type definition"
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                opts.desc = "list references"
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                opts.desc = "show signature information"
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                opts.desc = "renames all references"
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                opts.desc = "format using lsp client"
                vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                opts.desc = "Select code action"
                vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                -- defaults fix
                opts.desc = "show diagnostic message"
                vim.keymap.set('n', '<c-W>d', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
                opts.desc = "go to next diagnostic"
                vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
                opts.desc = "go to previous diagnostic"
                vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
                -- custom
                opts.desc = "show diagnostic message"
                vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
            end,
        })

        local capabilities = cmp_nvim_lsp.default_capabilities()

        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or border
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        mason_lspconfig.setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                })
            end,
        })
    end,
}
