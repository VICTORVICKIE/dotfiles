return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - Diff integration
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local neogit = require("neogit")
            neogit.setup({})
            vim.keymap.set("n", "<leader>g", function()
                neogit.open({ kind = "floating" })
            end)
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
