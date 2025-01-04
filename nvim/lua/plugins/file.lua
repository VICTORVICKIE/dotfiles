return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                columns = {
                    "icon",
                },
                view_options = {
                    show_hidden = true,
                },
                constrain_cursor = "name",
                skip_confirm_for_simple_edits = true,
            })

            -- Open parent directory in floating window
            vim.keymap.set("n", "<C-.>", function()
                require("oil").toggle_float()
            end)

            vim.keymap.set("n", "<C->>", function()
                require("oil").toggle_float(vim.fn.getcwd())
            end)
        end,
    },
}
