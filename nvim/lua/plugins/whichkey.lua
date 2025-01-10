return {
    "folke/which-key.nvim",
    event = "VimEnter",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        local wk = require("which-key")
        wk.setup({
            preset = "helix",
        })
        wk.add({
                { "<Leader>P", hidden = true },
                { "<Leader>Y", hidden = true },
                { "<Leader>d", hidden = true },
                { "<Leader>g", group = "git" },
                { "<Leader>g_", hidden = true },
                { "<Leader>l", group = "lsp" },
                { "<Leader>l_", hidden = true },
                { "<Leader>p", hidden = true },
                { "<Leader>r", group = "run" },
                { "<Leader>r_", hidden = true },
                { "<Leader>s", group = "surround" },
                { "<Leader>s_", hidden = true },
                { "<Leader>t", group = "telescope" },
                { "<Leader>t_", hidden = true },
                { "<Leader>u", group = "undo-tree" },
                { "<Leader>u_", hidden = true },
                { "<Leader>w", group = "window" },
                { "<Leader>w_", hidden = true },
                { "<Leader>y", hidden = true },
        })
    end,
}
