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
local plugins = {
    {
        "olimorris/persisted.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            local persisted = require("persisted")
            require("telescope").load_extension("persisted")

            persisted.setup({
                should_save = function()
                    local excluded_filetypes = {
                        "alpha",
                        "neo-tree",
                        "mason",
                        "lazy",
                    }

                    for _, excluded_ft in ipairs(excluded_filetypes) do
                        if vim.bo.filetype == excluded_ft then
                            return false
                        end
                    end

                    return true
                end,
            })
            local group = vim.api.nvim_create_augroup("PersistedHooks", {})

            vim.api.nvim_create_autocmd("User", {
                pattern = "PersistedTelescopeLoadPre",
                group = group,
                callback = function()
                    vim.lsp.stop_client(vim.lsp.get_clients())
                    persisted.save({ session = vim.g.persisted_loaded_session })
                    vim.cmd("%bd!")
                end,
            })
        end,
        -- opts = {
        --     -- Your custom config here
        -- },
    },
    -- Put any other plugins here
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "chip/telescope-software-licenses.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            -- Telescope UI Select
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = { i = { ["<C-v>"] = false } },
                },
                extensions = {
                    ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
                },
            })

            -- Enable telescope extensions, if they are installed
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")
        end,
    },
}
require("lazy").setup(plugins, {
    root = root .. "/plugins",
})
