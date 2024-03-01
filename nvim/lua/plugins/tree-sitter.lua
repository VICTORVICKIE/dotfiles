return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["ii"] = "@conditional.inner",
                            ["ai"] = "@conditional.outer",
                            ["il"] = "@loop.inner",
                            ["al"] = "@loop.outer",
                            ["ad"] = "@comment.outer",
                            ["id"] = "@comment.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        -- goto_next_start = {
                        --     ["]m"] = "@function.outer",
                        --     ["]]"] = "@class.outer",
                        -- },
                        -- goto_next_end = {
                        --     ["]M"] = "@function.outer",
                        --     ["]["] = "@class.outer",
                        -- },
                        -- goto_previous_start = {
                        --     ["[m"] = "@function.outer",
                        --     ["[["] = "@class.outer",
                        -- },
                        -- goto_previous_end = {
                        --     ["[M"] = "@function.outer",
                        --     ["[]"] = "@class.outer",
                        -- },
                        -- goto_next = {
                        --   [']i'] = "@conditional.inner",
                        -- },
                        -- goto_previous = {
                        --   ['[i'] = "@conditional.inner",
                        -- }
                    },
                    -- swap = {
                    --     enable = true,
                    --     swap_next = {
                    --         ["<leader>a"] = "@parameter.inner",
                    --     },
                    --     swap_previous = {
                    --         ["<leader>A"] = "@parameter.inner",
                    --     },
                    -- },
                },
            })
        end,
    },
}
