return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add          = { text = '+' },
            change       = { text = '~' },
            delete       = { text = '-' },
            topdelete    = { text = '-' },
            changedelete = { text = '=' },
            untraked     = { text = '.' },
        },
        signs_staged= {
            add          = { text = '+' },
            change       = { text = '~' },
            delete       = { text = '-' },
            topdelete    = { text = '-' },
            changedelete = { text = '=' },
            untraked     = { text = '.' },
        },
        numhl = true,
        on_attach = function(bufnr)
            local gitsigns = require('gitsigns')

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then
                    vim.cmd.normal({']c', bang = true})
                else
                    gitsigns.nav_hunk('next')
                end
            end)

            map('n', '[c', function()
                if vim.wo.diff then
                    vim.cmd.normal({'[c', bang = true})
                else
                    gitsigns.nav_hunk('prev')
                end
            end)

            -- Actions
            map('n', '<leader>hs', gitsigns.stage_hunk,                                                     { desc = "stage hunk" })
            map('n', '<leader>hr', gitsigns.reset_hunk,                                                     { desc = "reset hunk" })
            map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "stagw hunk" })
            map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "reset hunk" })
            map('n', '<leader>hu', gitsigns.undo_stage_hunk,                                                { desc = "undo stage hunk" })
            map('n', '<leader>hS', gitsigns.stage_buffer,                                                   { desc = "stage buffer" })
            map('n', '<leader>hR', gitsigns.reset_buffer,                                                   { desc = "reset buffer" })
            map('n', '<leader>hp', gitsigns.preview_hunk,                                                   { desc = "preview hunk" })
            map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end,                           { desc = "blame line" })
            map('n', '<leader>tb', gitsigns.toggle_current_line_blame,                                      { desc = "toggle current line blame" })
            map('n', '<leader>hd', gitsigns.diffthis,                                                       { desc = "preform vimdiff against index" })
            map('n', '<leader>hD', function() gitsigns.diffthis('~') end,                                   { desc = "preform vimdiff against last comit" })
            map('n', '<leader>td', gitsigns.toggle_deleted,                                                 { desc = "toggle show deleted" })

            -- Text object
            map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
    }
}
