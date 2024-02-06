return {
    { "ThePrimeagen/vim-be-good" },

    -- Color Code Highlight #069420
    {
        "uga-rosa/ccc.nvim",
        config = function()
            require("ccc").setup({
                highlighter = {
                    auto_enable = true,
                    lsp = true,
                },
            })
        end,
    },
    -- Auto Slash Comment
    {
        "numToStr/Comment.nvim",
        opts = {
            -- add any options here
        },
        lazy = false,
        config = function()
            require("Comment").setup()
            vim.api.nvim_set_keymap("n", "<C-/>", "gcc", { noremap = false })
            vim.api.nvim_set_keymap("v", "<C-/>", "gb<Esc>", { noremap = false })
            vim.api.nvim_set_keymap("v", "<C-?>", "gc<Esc>", { noremap = false })
            vim.api.nvim_set_keymap("i", "<C-/>", "<Esc>gcci", { noremap = false })
        end,
    },
    {
        "RaafatTurki/hex.nvim",
        config = function()
            require("hex").setup({})
        end,
    },
}
