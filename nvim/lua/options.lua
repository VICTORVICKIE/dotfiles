-- Neovide
if vim.g.neovide then
    vim.g.neovide_transparency = 0.99
    vim.g.neovide_refresh_rate = 144
end

-- Auto Command
local victor_group = vim.api.nvim_create_augroup("victor", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
    group = victor_group,
    callback = function()
        vim.cmd("cd $DEV")
    end,
})

local opt = vim.opt
-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Appearance
opt.relativenumber = true
opt.number = true
opt.termguicolors = true
-- opt.colorcolumn = '120'
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.scrolloff = 10
opt.completeopt = "menuone,noinsert,noselect"

-- Behaviour
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.iskeyword:append("-")
opt.mouse:append("a")
opt.clipboard:append("unnamedplus")
opt.modifiable = true
opt.encoding = "UTF-8"

-- Shell
opt.shell = "pwsh"
opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command "
opt.shellquote = ""
opt.shellxquote = ""
opt.shellpipe = "| Out-File -Encoding UTF8 %s"
opt.shellredir = "| Out-File -Encoding UTF8 %s"
vim.api.nvim_create_user_command("WinTerm", "!wt -d $PWD", {})
