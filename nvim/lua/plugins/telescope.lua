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
            local actions = require("telescope.actions")

            local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1
            local vimfnameescape = vim.fn.fnameescape
            local winfnameescape = function(path)
                local escaped_path = vimfnameescape(path)
                if is_windows then
                    local need_extra_esc = path:find("[%[%]`%$~]")
                    local esc = need_extra_esc and "\\\\" or "\\"
                    escaped_path = escaped_path:gsub("\\[%(%)%^&;]", esc .. "%1")
                    if need_extra_esc then
                        escaped_path = escaped_path:gsub("\\\\['` ]", "\\%1")
                    end
                end
                return escaped_path
            end
            local select_default = function(prompt_bufnr)
                vim.fn.fnameescape = winfnameescape
                local result = actions.select_default(prompt_bufnr, "default")
                vim.fn.fnameescape = vimfnameescape
                return result
            end
            telescope.setup({
                defaults = {
                    mappings = {
                        i = { ["<cr>"] = select_default, ["<C-v>"] = false },
                        n = { ["<cr>"] = select_default },
                    },
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
