return {
    -- Color Code Highlight #069420
    {
        "uga-rosa/ccc.nvim",
        event = "BufRead",
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
        lazy = false,
        config = function()
            require("Comment").setup()
            vim.api.nvim_set_keymap("n", "<C-/>", "gcc", { noremap = false })
            vim.api.nvim_set_keymap("v", "<C-/>", "gb<Esc>", { noremap = false })
            vim.api.nvim_set_keymap("v", "<C-?>", "gc<Esc>", { noremap = false })
            vim.api.nvim_set_keymap("i", "<C-/>", "<Esc>gcci", { noremap = false })
        end,
    },
    -- NOTE: Nice
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },
}
