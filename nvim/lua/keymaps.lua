-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("c", "<C-V>", "<C-r>*", { noremap = true })

local keymap = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = desc })
end

-- Keymaps

-- Terminal
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode")
vim.keymap.set('n', '<C-c>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- disable arrow keys
-- keymap({"n", "v"}, "<Up>", "<Nop>")
-- keymap({"n", "v"}, "<Down>", "<Nop>")
-- keymap({"n", "v"}, "<Right>", "<Nop>")
-- keymap({"n", "v"}, "<Left>", "<Nop>")

-- move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")
keymap("i", "<A-j>", "<esc>:m .+1<CR>==gi") -- Alt-j
keymap("i", "<A-k>", "<esc>:m .-2<CR>==gi") -- Alt-k
keymap("n", "<A-j>", ":m .+1<CR>==") -- Alt-j
keymap("n", "<A-k>", ":m .-2<CR>==") -- Alt-k

-- stay in indent mode
keymap("v", "<S-Tab>", "<gv") -- Right Indentation
keymap("v", "<Tab>", ">gv") -- Left Indentation

-- Window Management
keymap("n", "<leader>wv", ":vsplit<CR>", "split vertical") -- Split Vertical
keymap("n", "<leader>wh", ":split<CR>", "split horizontal") -- Split Horizontal
keymap("n", "<leader>wm", ":MaximizerToggle<CR>", "split toggle") -- Toggle Minimize
keymap("n", "<C-b>", ":vsplit .<CR>")
keymap("n", "<C-k>", "<c-w>k")
keymap("n", "<C-j>", "<c-w>j")
keymap("n", "<C-h>", "<c-w>h")
keymap("n", "<C-l>", "<c-w>l")

-- Primeagen Suggestion
-- join lines with space without cursor jump
keymap("n", "J", "mzJ`z")
-- keeps cursor at middle of rows
keymap("n", "<C-b>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

keymap("x", "<leader>p", '"_dP')
vim.keymap.set({"n", "v"}, "<leader>p", '"+p', {remap = true})
vim.keymap.set({"n", "v"}, "<leader>P", '"+P', {remap = true})
vim.keymap.set({"n", "v"}, "<leader>y", '"+y', {remap = true})
vim.keymap.set({"n", "v"}, "<leader>Y", '"+Y', {remap = true})
keymap({ "n", "v" }, "<leader>d", '"_d')
keymap("i", "<C-c>", "<Esc>")

-- Neovide

if vim.g.neovide then
    keymap("n", "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1<CR>")
    keymap("n", "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 0.9<CR>")
    keymap("n", "<C-BS>", ":lua vim.g.neovide_scale_factor = 1.0<CR>")
end

