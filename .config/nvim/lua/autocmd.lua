local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local delacmd = vim.api.nvim_clear_autocmds

local general = augroup("General Settings", { clear = true })
local buffer = augroup("Normal Buffer Settings", { clear = true })

-- Highlight when yanking
autocmd("TextYankPost", {
    callback = function()
        require("vim.hl").on_yank({ higroup = "Visual", timeout = 200 })
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
    group = buffer,
})
autocmd("InsertLeave", {
    callback = function()
        vim.opt_local.relativenumber = true
    end,
    group = buffer,
})

-- No continue comments on new line
autocmd("FileType", {
    callback = function()
        vim.opt_local.formatoptions:remove({ 'r', 'o' })
    end,
    group = general,
})
