return {
    "nvim-telescope/telescope.nvim", tag = '0.1.8',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "find files" })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { desc = "live grep" })
        vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = "list buffers" })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { desc = "list help tags" })
    end,
}
