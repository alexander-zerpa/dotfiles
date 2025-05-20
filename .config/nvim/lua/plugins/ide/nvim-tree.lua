return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        -- vim.g.loaded_netrw = 1
        -- vim.g.loaded_netrwPlugin = 1

        local nvim_tree_api = require("nvim-tree.api")

        -- Make :bd and :q behave as usual when tree is visible
        vim.api.nvim_create_autocmd({ 'BufEnter', 'QuitPre' }, {
            nested = false,
            callback = function(e)
                local tree = nvim_tree_api.tree

                -- Nothing to do if tree is not opened
                if not tree.is_visible() then
                    return
                end

                -- How many focusable windows do we have? (excluding e.g. incline status window)
                local winCount = 0
                for _, winId in ipairs(vim.api.nvim_list_wins()) do
                    if vim.api.nvim_win_get_config(winId).focusable then
                        winCount = winCount + 1
                    end
                end

                -- We want to quit and only one window besides tree is left
                if e.event == 'QuitPre' and winCount == 2 then
                    vim.api.nvim_cmd({ cmd = 'qall' }, {})
                end

                -- :bd was probably issued an only tree window is left
                -- Behave as if tree was closed (see `:h :bd`)
                if e.event == 'BufEnter' and winCount == 1 then
                    -- Required to avoid "Vim:E444: Cannot close last window"
                    vim.defer_fn(function()
                        -- close nvim-tree: will go to the last buffer used before closing
                        tree.toggle({ find_file = true, focus = true })
                        -- re-open nivm-tree
                        tree.toggle({ find_file = true, focus = false })
                    end, 10)
                end
            end
        })

        nvim_tree_api.events.subscribe(nvim_tree_api.events.Event.TreeOpen, function()
            local tree_winid = nvim_tree_api.tree.winid()
            if tree_winid ~= nil then
                vim.api.nvim_set_option_value("statusline", " ", { win = tree_winid })
            end
        end)

        -- local nvimTreeFocusOrToggle = function()
        --   local currentBuf = vim.api.nvim_get_current_buf()
        --   local currentBufFt = vim.api.nvim_get_option_value("filetype", {buf = currentBuf})
        --   if currentBufFt == "NvimTree" then
        --     nvim_tree_api.tree.toggle()
        --   else
        --     nvim_tree_api.tree.focus()
        --   end
        -- end

        require("nvim-tree").setup({})

        -- vim.keymap.set("n", "<leader>f", nvimTreeFocusOrToggle,             { desc = "Toggle NvimTree" })
        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>",         { desc = "Toggle NvimTree" })
        vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle NvimTree on current file" })
    end,
}
