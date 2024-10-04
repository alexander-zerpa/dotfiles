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

}

for k, v in pairs(options) do
    vim.opt[k] = v
end
