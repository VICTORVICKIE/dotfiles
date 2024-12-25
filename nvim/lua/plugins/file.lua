return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        visible = true,
                        hide_dotfiles = false,
                        hide_gitignored = false,
                        hide_hidden = false,
                    },
                },
            })
            vim.keymap.set("n", "<C-m>", ":Neotree filesystem toggle right<CR>", { silent = true })
        end,
    },
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
