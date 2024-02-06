return {
    {
        "olimorris/persisted.nvim",
        config = function()
            require("persisted").setup({
                should_autosave = function()
                    local excluded_filetypes = {
                        "alpha",
                        "mason",
                        "lazy",
                        "",
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

            vim.api.nvim_create_autocmd({ "User" }, {
                pattern = "PersistedSavePre",
                group = group,
                callback = function()
                    vim.cmd([[Neotree close]])
                end,
            })
            vim.api.nvim_create_autocmd({ "User" }, {
                pattern = "PersistedTelescopeLoadPre",
                group = group,
                callback = function()
                    vim.cmd([[Neotree close]])
                    require("persisted").save({ session = vim.g.persisted_loaded_session })
                    vim.api.nvim_input("<ESC>:%bd<CR>")
                    vim.lsp.stop_client(vim.lsp.get_active_clients())
                end,
            })
            vim.api.nvim_create_autocmd({ "User" }, {
                pattern = "PersistedTelescopeLoadPost",
                group = group,
                callback = function(session)
                    vim.schedule(function()
                        vim.cmd("cd " .. session.data.dir_path)
                        print("Loaded session: " .. session.data.name)
                    end)
                end,
            })
        end,
    },
    {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup({})
        end,
    },
}
