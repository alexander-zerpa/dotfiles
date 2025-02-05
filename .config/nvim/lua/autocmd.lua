local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local general = augroup("General Settings", { clear = true })

-- Highlight when yanking
autocmd("TextYankPost", {
    callback = function()
        require("vim.highlight").on_yank({higroup = "Visual", timeout = 200})
    end,
    group = general,
})

-- Equalize splits on resize
autocmd("VimResized", {
    callback = function()
        vim.cmd([[ wincmd = ]])
    end,
    group = general,
})

-- Change to absolute numbers on insert
autocmd("InsertEnter", {
    callback = function()
        vim.opt_local.relativenumber = false
    end,
    group = general,
})
autocmd("InsertLeave", {
    callback = function()
        vim.opt_local.relativenumber = true
    end,
    group = general,
})

-- No continue comments on new line
autocmd("FileType", {
    callback = function()
        vim.opt_local.formatoptions:remove({ 'r', 'o' })
    end,
    group = general,
})

-- No numbers on terminal mode
autocmd("TermOpen", {
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
    group = general,
})
