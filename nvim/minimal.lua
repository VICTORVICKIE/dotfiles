-- NOTE: See the end of this file if you are reporting an issue, etc. Ignore all the "scary" functions up top, those are
-- used for setup and other operations.
local M = {}

local base_root_path = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h") .. "/.min"
function M.root(path)
    return base_root_path .. "/" .. (path or "")
end

function M.load_plugin(plugin_name, plugin_url)
    local package_root = M.root("plugins/")
    local install_destination = package_root .. plugin_name
    vim.opt.runtimepath:append(install_destination)

    if not vim.loop.fs_stat(package_root) then
        vim.fn.mkdir(package_root, "p")
    end

    if not vim.loop.fs_stat(install_destination) then
        print(string.format("> Downloading plugin '%s' to '%s'", plugin_name, install_destination))
        vim.fn.system({
            "git",
            "clone",
            "--depth=1",
            plugin_url,
            install_destination,
        })
        if vim.v.shell_error > 0 then
            error(
                string.format("> Failed to clone plugin: '%s' in '%s'!", plugin_name, install_destination),
                vim.log.levels.ERROR
            )
        end
    end
end

---@alias PluginName string The plugin name, will be used as part of the git clone destination
---@alias PluginUrl string The git url at which a plugin is located, can be a path. See https://git-scm.com/book/en/v2/Git-on-the-Server-The-Protocols for details
---@alias MinPlugins table<PluginName, PluginUrl>

---Do the initial setup. Downloads plugins, ensures the minimal init does not pollute the filesystem by keeping
---everything self contained to the CWD of the minimal init file. Run prior to running tests, reproducing issues, etc.
---@param plugins? table<PluginName, PluginUrl>
function M.setup(plugins)
    vim.opt.packpath = {} -- Empty the package path so we use only the plugins specified
    vim.opt.runtimepath:append(M.root(".min")) -- Ensure the runtime detects the root min dir

    -- Install required plugins
    if plugins ~= nil then
        for plugin_name, plugin_url in pairs(plugins) do
            M.load_plugin(plugin_name, plugin_url)
        end
    end

    vim.env.XDG_CONFIG_HOME = M.root("xdg/config")
    vim.env.XDG_DATA_HOME = M.root("xdg/data")
    vim.env.XDG_STATE_HOME = M.root("xdg/state")
    vim.env.XDG_CACHE_HOME = M.root("xdg/cache")

    -- NOTE: Cleanup the xdg cache on exit so new runs of the minimal init doesn't share any previous state, e.g. shada
    vim.api.nvim_create_autocmd("VimLeave", {
        callback = function()
            vim.fn.system({
                "rm",
                "-r",
                "-f",
                M.root("xdg"),
            })
        end,
    })
end

-- NOTE: If you have additional plugins you need to install to reproduce your issue, include them in the plugins
-- table within the setup call below.
M.setup({
    plenary = "https://github.com/nvim-lua/plenary.nvim.git",
    telescope = "https://github.com/nvim-telescope/telescope.nvim",
    diffview = "https://github.com/sindrets/diffview.nvim",
    neogit = "https://github.com/NeogitOrg/neogit",
})
-- WARN: Do all plugin setup, test runs, reproductions, etc. AFTER calling setup with a list of plugins!
-- Basically, do all that stuff AFTER this line.
require("neogit").setup({
    kind = "floating",
    popup = {
        kind = "floating",
    },
    commit_editor = {
        kind = "floating",
    },
    commit_select_view = {
        kind = "floating",
    },
    commit_view = {
        kind = "floating",
        verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
    },
    log_view = {
        kind = "floating",
    },
    rebase_editor = {
        kind = "floating",
    },
    reflog_view = {
        kind = "floating",
    },
    merge_editor = {
        kind = "floating",
    },
    tag_editor = {
        kind = "floating",
    },
    preview_buffer = {
        kind = "floating",
    },
}) -- For instance, setup Neogit
