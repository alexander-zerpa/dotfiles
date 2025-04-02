vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local keymap = vim.keymap

-- Modes
-- normal_mode:         'n'
-- insert_mode:         'i'
-- visual_mode:         'v'
-- visual_block_mode:   'x'
-- command_mode:        'c'
-- term_mode:           't'

-- -- Substitution
-- keymap.set('n', 's', ':s/',  { desc = "start substitution matching" })
-- keymap.set('n', 'S', ':%s/', { desc = "file substitution matching" })
-- keymap.set('v', 's', ':s/',  { desc = "start substitution matching" })
-- keymap.set('v', 'S', ':%s/', { desc = "file substitution matching" })

-- Line Insert
keymap.set('n', '<A-n>', "<cmd>call append(line('.'), '')<CR>",   { desc = "insert empty line after cursor" })
keymap.set('n', '<A-p>', "<cmd>call append(line('.')-1, '')<CR>", { desc = "insert empty line before cursor" })

-- Clipboard
-- Copy
keymap.set('n', 'cy', '"+y', { desc = "clipboard copy" })
keymap.set('n', 'cY', '"+Y', { desc = "clipboard copy line" })
keymap.set('v', 'cy', '"+y', { desc = "clipboard copy" })
keymap.set('v', 'cY', '"+Y', { desc = "clipboard copy line" })
-- Paste
keymap.set('n', 'cp', '"+p', { desc = "clipboard paste" })
keymap.set('n', 'cP', '"+P', { desc = "clipboard paste previus" })
keymap.set('v', 'cp', '"+p', { desc = "clipboard paste" })
keymap.set('v', 'cP', '"+P', { desc = "clipboard paste previus" })

-- Midle click clipboard
-- Copy
keymap.set('n', 'Cy', '"*y', { desc = "middle-click copy" })
keymap.set('n', 'CY', '"*Y', { desc = "middle-click copy line" })
keymap.set('v', 'Cy', '"*y', { desc = "middle-click copy" })
keymap.set('v', 'CY', '"*Y', { desc = "middle-click copy line" })
-- Paste
keymap.set('n', 'Cp', '"*p', { desc = "middle-click paste" })
keymap.set('n', 'CP', '"*P', { desc = "middle-click paste previus" })
keymap.set('v', 'Cp', '"*p', { desc = "middle-click paste" })
keymap.set('v', 'CP', '"*P', { desc = "middle-click paste previus" })

-- Split Navigation
keymap.set('n', '<C-h>', '<C-w>h', { desc = "move focus left" })
keymap.set('n', '<C-j>', '<C-w>j', { desc = "move focus down" })
keymap.set('n', '<C-k>', '<C-w>k', { desc = "move focus up" })
keymap.set('n', '<C-l>', '<C-w>l', { desc = "move focus right" })

-- Stay Vusual Mode when changing indentation
keymap.set('v', '<', '<gv', { desc = "reduce indentation" })
keymap.set('v', '>', '>gv', { desc = "increase indentation" })

-- Moving text
keymap.set('n', '<A-j>', "<cmd>move .+1<CR>",   { desc = "move line down" })
keymap.set('n', '<A-k>', "<cmd>move .-2<CR>",   { desc = "move line up" })
keymap.set('v', '<A-j>', ":move '>+1<CR>gv",    { desc = "move line down" })
keymap.set('v', '<A-k>', ":move '<-2<CR>gv",    { desc = "move line up" })

-- <Tab> to buffer cycling
keymap.set('n', '<Tab>',   "<cmd>bnext<CR>",     { desc = "cycle buffer" })
keymap.set('n', '<S-Tab>', "<cmd>bprevious<CR>", { desc = "cycle buffer" })

-- Terminal Keybinds
keymap.set('t', '<C-ESC>', "<C-\\><C-n>",       { desc = "exit terminal mode" })
keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h',   { desc = "move focus left" })
keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j',   { desc = "move focus down" })
keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k',   { desc = "move focus up" })
keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l',   { desc = "move focus right" })
keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>',    { desc = "window movement options" })
