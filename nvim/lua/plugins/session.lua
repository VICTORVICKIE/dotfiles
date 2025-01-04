return {
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },
    {
        "olimorris/persisted.nvim",
        config = function()
            local persisted = require("persisted")

            persisted.setup({
                autostart = true,
                should_save = function()
                    local excluded_filetypes = {
                        "alpha",
                        "neo-tree",
                        "mason",
                        "lazy",
                        "fugitive",
                    }

                    for _, excluded_ft in ipairs(excluded_filetypes) do
                        if vim.bo.filetype == excluded_ft then
                            return false
                        end
                    end

                    return true
                end,
            })

            require("telescope").load_extension("persisted")

            vim.keymap.set("n", "<Leader>ts", function()
                vim.cmd("Telescope persisted")
            end, { desc = "session" })

            local group = vim.api.nvim_create_augroup("PersistedHooks", {})

            vim.api.nvim_create_autocmd("User", {
                pattern = "PersistedTelescopeLoadPre",
                group = group,
                callback = function()
                    vim.lsp.stop_client(vim.lsp.get_clients())
                    vim.cmd("DelHidBufs") -- ../commands.lua
                    persisted.save({ session = vim.g.persisted_loaded_session })
                    vim.cmd("%bd!")
                end,
            })
        end,
    },
    {
        "Pocco81/auto-save.nvim",
        event = { "InsertLeave", "TextChanged" },
        config = function()
            require("auto-save").setup({
                trigger_events = { "TextChanged" },
                condition = function(buf)
                    local fn = vim.fn
                    local utils = require("auto-save.utils.data")

                    if
                        fn.getbufvar(buf, "&modifiable") == 1
                        and utils.not_in(fn.getbufvar(buf, "&filetype"), { "harpoon", "oil", "neo-tree", "fugitive" })
                    then
                        return true -- met condition(s), can save
                    end
                    return false -- can't save
                end,
            })
        end,
    },
}
