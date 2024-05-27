return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local neogit = require("neogit")
            neogit.setup({
                mappings = {
                    commit_editor = {
                        ["<C-y>"] = "Submit",
                        ["<C-c>"] = "Abort",
                    },
                    commit_editor_I = {
                        ["<C-y>"] = "Submit",
                        ["<C-c>"] = "Abort",
                    },
                    rebase_editor = {
                        ["<C-y>"] = "Submit",
                        ["<C-c>"] = "Abort",
                    },
                    rebase_editor_I = {
                        ["<C-y>"] = "Submit",
                        ["<C-c>"] = "Abort",
                    },
                },
            })
            vim.keymap.set("n", "<leader>g", neogit.open)
        end,
    },
    -- {
    --     "tpope/vim-fugitive",
    --     config = function()
    --         vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    --     end,
    -- },
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
}
