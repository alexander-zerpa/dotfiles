local options = {
    title = true,

    number = true,
    relativenumber = true,

    smartindent = true,

    ignorecase = true,
    smartcase = true,
    incsearch = true,
    hlsearch = true,

    wrap = false,

    confirm = true,

    foldenable = false,
    foldmethod = "syntax",

    tabstop = 4,
    shiftwidth = 0,
    expandtab = true,

    splitbelow = true,
    splitright = true,

    mouse = 'a',

    textwidth = 80,
    colorcolumn = '+1',

    winborder = 'rounded',

    showmode = false,

    list = true,
    listchars = {
        tab = '» ',       -- Show tabs as '» '
        trail = '·',      -- Show trailing spaces as dots
        nbsp = '␣',       -- Show non-breaking spaces
        extends = '›',    -- Character to show in the last column when wrap is off
        precedes = '‹',   -- Character to show in the first column when wrap is off
        -- eol = '↲',        -- Optional: Show a character at the end of each line
    }
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
