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
            })

            -- Open parent directory in floating window
            vim.keymap.set("n", "<C-n>", require("oil").toggle_float)
        end,
    },
}
