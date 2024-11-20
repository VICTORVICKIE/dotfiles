-- Neovide
if vim.g.neovide then
    vim.g.neovide_transparency = 1.0
    vim.g.neovide_refresh_rate = 144
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_scroll_animation_length = 0
    vim.g.neovide_unlink_border_highlights = true
end

local opt = vim.opt
-- Indentation
opt.tabstop = 4
opt.wrap = false
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.smartcase = true
opt.ignorecase = true

-- Appearance
opt.relativenumber = true
opt.number = true
opt.guifont = "IosevkaTermSlab Nerd Font Mono:h14"
opt.termguicolors = true
-- opt.colorcolumn = '120'
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.scrolloff = 2
opt.completeopt = "menuone,noinsert,noselect"
opt.fillchars = {
    eob = " ",
    horiz = "═",
    horizup = "╩",
    horizdown = "╦",
    vert = "║",
    vertleft = "╣",
    vertright = "╠",
    verthoriz = "╬",
}
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", eol = "↲" }

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
opt.mousemoveevent = true
-- opt.clipboard:append("unnamedplus")
opt.modifiable = true
opt.encoding = "UTF-8"
opt.updatetime = 250
opt.timeoutlen = 500
-- Shell
if vim.fn.has("win32") == 1 and vim.fn.executable("pwsh") == 1 then
    opt.ff = "dos"
    opt.shell = "pwsh"
    opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command "
    opt.shellquote = ""
    opt.shellxquote = ""
    opt.shellpipe = "| Out-File -Encoding UTF8 %s>"
    opt.shellredir = "| Out-File -Encoding UTF8 %s"
elseif vim.fn.has("wsl") then
    opt.ff = "unix"
    opt.shell = "bash -l"
end
