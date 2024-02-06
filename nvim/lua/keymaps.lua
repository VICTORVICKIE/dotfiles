-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("c", "<C-V>", "<C-r>*", { noremap = true })
-- Keymaps
keymap("n", "<C-k>", "<c-w>k", opts)
keymap("n", "<C-j>", "<c-w>j", opts)
keymap("n", "<C-h>", "<c-w>h", opts)
keymap("n", "<C-l>", "<c-w>l", opts)
--[[ keymap({"n", "v"}, "<Up>", "<Nop>")
keymap({"n", "v"}, "<Down>", "<Nop>")
keymap({"n", "v"}, "<Right>", "<Nop>")
keymap({"n", "v"}, "<Left>", "<Nop>") ]]
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
keymap("n", "<leader>sv", ":vsplit<CR>", opts)          -- Split Vertical
keymap("n", "<leader>sh", ":split<CR>", opts)           -- Split Horizontal
keymap("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- Toggle Minimize

-- Primeagen Suggestion
-- join lines with space without cursor jump
keymap("n", "J", "mzJ`z")
-- keeps cursor at middle of rows
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("x", "<leader>p", [["_dP]])
keymap({ "n", "v" }, "<leader>d", [["_d]])
keymap("i", "<C-c>", "<Esc>")
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
