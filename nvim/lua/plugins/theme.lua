return {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
        "folke/tokyonight.nvim",
    },
    config = function()
        local colors = require("colors")
        require("monokai-pro").setup({

            styles = {
                type = { italic = false },
                comment = { italic = true },
                keyword = { italic = false },
                structure = { italic = false },
                parameter = { italic = false },
                annotation = { italic = false },
                storageclass = { italic = false },
                tag_attribute = { italic = false },
            },

            background_clear = { "float_win", "telescope", "which-key" },

            override = function(c)
                return {
                    NonText = { fg = colors.dark3 },
                    VM_Mono = { link = "TermCursor"},
                    VM_Extend = { link = "IncSearch"},
                    VM_Cursor = { link = "TermCursor"},
                    VM_Insert = { link = "CursorLine"},
                    WinSeparator = { fg = c.base.white },
                    LspReferenceText = { link = "Visual" },
                    LspReferenceRead = { link = "Visual" },
                    LspReferenceWrite = { link = "Visual" },
                    Directory = { fg = c.base.blue, bg = colors.background },
                }
            end,

            overridePalette = function()
                return {
                    text = colors.fg,
                    background = colors.bg,

                    dark1 = colors.bg_dark,
                    dark2 = colors.bg_dark1,

                    accent1 = colors.red,
                    accent2 = colors.blue,
                    accent3 = colors.yellow,
                    accent4 = colors.green,
                    accent5 = colors.blue2,
                    accent6 = colors.purple,

                    dimmed1 = colors.dark5,
                    dimmed2 = colors.fg_dark,
                    dimmed3 = colors.comment,
                    dimmed4 = colors.fg_gutter,
                    dimmed5 = colors.bg_dark,
                }
            end,
        })
        vim.cmd.colorscheme("monokai-pro")
    end,
}
