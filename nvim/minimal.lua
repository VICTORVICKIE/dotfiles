local root = "/tmp/persisted"

-- Set stdpaths to use root dir
for _, name in ipairs({ "config", "data", "state", "cache" }) do
    vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

-- Bootstrap lazy
local lazypath = root .. "/plugins/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

vim.opt.sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize" -- Session options to store in the session

-- Install plugins
local plugins = {}
require("lazy").setup(plugins, {
    root = root .. "/plugins",
})
