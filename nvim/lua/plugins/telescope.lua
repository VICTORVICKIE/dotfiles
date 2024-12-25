return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VimEnter",
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup()

            vim.keymap.set("n", "<A-h>", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)
            vim.keymap.set("n", "<A-a>", function()
                harpoon:list():append()
            end)
            vim.keymap.set("n", "<A-1>", function()
                harpoon:list():select(1)
            end)
            vim.keymap.set("n", "<A-2>", function()
                harpoon:list():select(2)
            end)
            vim.keymap.set("n", "<A-3>", function()
                harpoon:list():select(3)
            end)
            vim.keymap.set("n", "<A-4>", function()
                harpoon:list():select(4)
            end)
        end,
    },
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "chip/telescope-software-licenses.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            -- Telescope UI Select
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = { i = { ["<C-v>"] = false } },
                },
                extensions = {
                    ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
                },
            })

            -- Enable telescope extensions, if they are installed
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")
            -- pcall(require("telescope").load_extension, "software-licenses")

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<Leader>th", builtin.help_tags, { desc = "help" })
            vim.keymap.set("n", "<Leader>tb", builtin.builtin, { desc = "builtin" })
            vim.keymap.set("n", "<Leader>tf", builtin.find_files, { desc = "file" })
            vim.keymap.set("n", "<Leader>tk", builtin.keymaps, { desc = "keymaps" })
            vim.keymap.set("n", "<Leader>tl", builtin.live_grep, { desc = "live grep" })
            vim.keymap.set("n", "<Leader>td", builtin.diagnostics, { desc = "diagnostics" })
            vim.keymap.set("n", "<Leader>tr", builtin.grep_string, { desc = "grep string" })
            vim.keymap.set("n", "<Leader>tp", builtin.filetypes, { desc = "pick filetype" })
            vim.keymap.set("n", "<Leader>tg", builtin.git_branches, { desc = "git branch" })
        end,
    },
}
