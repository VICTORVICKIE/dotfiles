return {
    "folke/which-key.nvim",
    enabled = false,
    event = "VimEnter",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        local which_key = require("which-key")
        which_key.setup({
            window = {
                border = "single",
                margin = { 1, 2, 1, 0 },
            },
            layout = { align = "center" },
        })
        which_key.register({
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
            -- ["<Leader>g"] = { name = "git", _ = "which_key_ignore" },
            -- ["<Leader>l"] = { name = "lsp", _ = "which_key_ignore" },
            -- ["<Leader>r"] = { name = "run", _ = "which_key_ignore" },
            -- ["<Leader>w"] = { name = "window", _ = "which_key_ignore" },
            -- ["<Leader>s"] = { name = "surround", _ = "which_key_ignore" },
            -- ["<Leader>t"] = { name = "telescope", _ = "which_key_ignore" },
            -- ["<Leader>u"] = { name = "undo-tree", _ = "which_key_ignore" },
            -- ["<Leader>d"] = "which_key_ignore",
            -- ["<Leader>p"] = "which_key_ignore",
            -- ["<Leader>P"] = "which_key_ignore",
            -- ["<Leader>y"] = "which_key_ignore",
            -- ["<Leader>Y"] = "which_key_ignore",
        })
    end,
}
