return {
    {
        "https://git.sr.ht/~swaits/scratch.nvim",
        lazy = true,
        cmd = {
            "Scratch",
            "ScratchSplit",
        },
        opts = {},
    },
    { "tpope/vim-abolish" },
    {
        "ej-shafran/compile-mode.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "m00qek/baleia.nvim", tag = "v1.3.0" },
        },
        config = function()
            ---@type CompileModeOpts
            vim.g.compile_mode = {
                baleia_setup = true,
            }
        end,
    },
    {
        "Vonr/align.nvim",
        branch = "v2",
        lazy = true,
        init = function()
            local NS = { noremap = true, silent = true }
            -- Aligns to 1 character
            vim.keymap.set("x", "<leader>ac", function()
                require("align").align_to_char({
                    length = 1,
                })
            end, NS)

            -- Aligns to a string with previews
            vim.keymap.set("x", "<leader>aw", function()
                require("align").align_to_string({
                    preview = true,
                    regex = false,
                })
            end, NS)

            -- Aligns to a Vim regex with previews
            vim.keymap.set("x", "<leader>ar", function()
                require("align").align_to_string({
                    preview = true,
                    regex = true,
                })
            end, NS)
        end,
    },
}
