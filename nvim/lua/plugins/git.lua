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
