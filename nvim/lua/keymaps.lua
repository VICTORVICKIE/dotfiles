-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
-- Keymaps
keymap("n", "<C-k>", "<c-w>k", opts)
keymap("n", "<C-j>", "<c-w>j", opts)
keymap("n", "<C-h>", "<c-w>h", opts)
keymap("n", "<C-l>", "<c-w>l", opts)

-- move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
keymap("i", "<A-j>", "<esc>:m .+1<CR>==gi", opts) -- Alt-j
keymap("i", "<A-k>", "<esc>:m .-2<CR>==gi", opts) -- Alt-k
keymap("n", "<A-j>", ":m .+1<CR>==", opts)        -- Alt-j
keymap("n", "<A-k>", ":m .-2<CR>==", opts)        -- Alt-k

-- stay in indent mode
keymap("v", "<S-Tab>", "<gv", opts) -- Right Indentation
keymap("v", "<Tab>", ">gv", opts)   -- Left Indentation

-- Window Management
-- keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) -- Split Vertical
-- keymap.set("n", "<leader>sh", ":split<CR>", opts) -- Split Horizontal
-- keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- Toggle Minimize

