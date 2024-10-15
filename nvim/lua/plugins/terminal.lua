return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            direction = "float",
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.keymap.set("n", "q", ":close<CR>", {
                    noremap = true,
                    silent = true,
                    buffer = term.bufnr,
                })
            end,
            on_close = function()
                vim.cmd("startinsert!")
            end,
        })

        local terminal = function(cmd)
            return require("toggleterm.terminal").Terminal:new({ cmd = cmd, dir = "git_dir" })
        end

        vim.keymap.set("n", "<leader>gm", function()
            terminal("gitu"):toggle()
        end, { noremap = true, silent = true, desc = "gitu" })

        vim.keymap.set("n", "<leader>gl", function()
            terminal("lazygit"):toggle()
        end, { noremap = true, silent = true, desc = "lazygit" })

        vim.keymap.set("n", "<leader>rp", ":RunWT pwsh<CR>", { silent = true, desc = "pwsh core" })
        vim.keymap.set("n", "<leader>rt", ":ToggleTerm<CR>", { silent = true, desc = "toggle term" }) -- based on vim.opt.shell
        vim.keymap.set("n", "<leader>ru", ":RunWT  wsl<CR>", { silent = true, desc = "wsl ubuntu" })
    end,
}
