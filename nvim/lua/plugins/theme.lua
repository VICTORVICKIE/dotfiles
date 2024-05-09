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
                comment = { italic = true },
                keyword = { italic = false }, -- any other keyword
                type = { italic = false }, -- (preferred) int, long, char, etc
                storageclass = { italic = false }, -- static, register, volatile, etc
                structure = { italic = false }, -- struct, union, enum, etc
                parameter = { italic = false }, -- parameter pass in function
                annotation = { italic = false },
                tag_attribute = { italic = false }, -- attribute of tag in reactjs
            },

            background_clear = { "float_win", "telescope", "which-key" },

            override = function(c)
                return {
                    NonText = { fg = colors.dark3 },
                    Directory = { fg = c.base.blue, bg = colors.background },
                    WinSeparator = { fg = c.base.white },
                    LspReferenceText = { link = "Visual" },
                    LspReferenceRead = { link = "Visual" },
                    LspReferenceWrite = { link = "Visual" },
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
