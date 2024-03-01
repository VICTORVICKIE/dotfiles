return { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]parenthen
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({ n_lines = 500 })

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup({
            mappings = {
                add = "<leader>sa", -- Add surrounding in Normal and Visual modes
                delete = "<leader>sd", -- Delete surrounding
                find = "<leader>sf", -- Find surrounding (to the right)
                find_left = "<leader>sF", -- Find surrounding (to the left)
                highlight = "<leader>sh", -- Highlight surrounding
                replace = "<leader>sr", -- Replace surrounding
                update_n_lines = "<leader>sn", -- Update `n_lines`

                suffix_last = "l", -- Suffix to search with "prev" method
                suffix_next = "n", -- Suffix to search with "next" method
            },
        })
    end,
}
