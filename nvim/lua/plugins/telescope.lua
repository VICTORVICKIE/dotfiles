return {
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
            --
            { "nvim-telescope/telescope-file-browser.nvim" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    mappings = { i = { ["<C-v>"] = false } },
                    initial_mode = "insert",
                    hidden = true,
                    no_ignore = true,
                    file_ignore_patterns = {
                        "node_modules",
                        ".git",
                        ".svelte-kit",
                        ".next",
                        "build",
                    },
                },
                extensions = {
                    ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        find_command = {
                            "rg",
                            "--files",
                            "--color=never",
                            "--no-heading",
                            "--line-number",
                            "--column",
                            "--smart-case",
                            "--hidden",
                            "--glob",
                            "!{.git/*,.svelte-kit/*,target/*,node_modules/*}",
                            "--path-separator",
                            "/",
                        },
                    },
                },
            })

            -- Enable telescope extensions, if they are installed
            pcall(telescope.load_extension, "fzf")
            pcall(telescope.load_extension, "ui-select")
            pcall(telescope.load_extension, "file_browser")
            -- pcall(telescope.load_extension, "software-licenses")

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<Leader>th", builtin.help_tags, { desc = "help" })
            vim.keymap.set("n", "<Leader>tf", builtin.find_files, { desc = "file" })
            vim.keymap.set("n", "<Leader>tk", builtin.keymaps, { desc = "keymaps" })
            vim.keymap.set("n", "<Leader>tl", builtin.live_grep, { desc = "live grep" })
            vim.keymap.set("n", "<Leader>td", builtin.diagnostics, { desc = "diagnostics" })
            vim.keymap.set("n", "<Leader>tr", builtin.grep_string, { desc = "grep string" })
            vim.keymap.set("n", "<Leader>tp", builtin.filetypes, { desc = "pick filetype" })
            vim.keymap.set("n", "<Leader>tg", builtin.git_branches, { desc = "git branch" })
            vim.keymap.set("n", "<Leader>tb", function()
                telescope.extensions.file_browser.file_browser()
            end, { desc = "browser" })
        end,
    },
}
