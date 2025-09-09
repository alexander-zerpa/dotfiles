return {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ft = 'markdown',
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        render_modes = true,
        completions = {
            lsp = {
                enable = true,
            },
        },
        code = {
            width = 'block',
            min_width = 80,
            language_border = ' ',
            language_left = '',
            language_right = '',
        },
        dash = { 
            width = 80,
        },
        heading = {
            width = 'block',
            min_width =  80,
        },
    },
}
