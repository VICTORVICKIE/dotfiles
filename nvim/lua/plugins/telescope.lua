return {
    -- Telescope UI Select
    { "nvim-telescope/telescope-ui-select.nvim" },
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
                },
            })

            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("persisted")
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>tf", builtin.find_files, {})
            vim.keymap.set("n", "<leader>tg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>ts", function()
                vim.cmd([[Telescope persisted]])
            end, {})
        end,
    },
}
