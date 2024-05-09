return {
    "folke/which-key.nvim",
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
            ["<Leader>d"] = { name = "diagnostics", _ = "which_key_ignore" },
            ["<Leader>g"] = { name = "git", _ = "which_key_ignore" },
            ["<Leader>l"] = { name = "lsp", _ = "which_key_ignore" },
            ["<Leader>s"] = { name = "surround", _ = "which_key_ignore" },
            ["<Leader>t"] = { name = "telescope", _ = "which_key_ignore" },
            ["<Leader>w"] = { name = "window", _ = "which_key_ignore" },
        })
    end,
}
