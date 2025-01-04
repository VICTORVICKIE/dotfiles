return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
        local lualine = require("lualine")
        local c = require("colors")
        local colors = {
            fg = c.fg,
            bg = c.bg,
            subtle = c.fg_gutter,

            red = c.red,
            green = c.green,
            blue = c.blue2,

            yellow = c.yellow,
            orange = c.orange,
            magenta = c.magenta,
            cyan = c.cyan,
            violet = c.purple,
        }

        local function mode_color()
            -- auto change color according to neovims mode
            local mode_colors = {
                n = colors.red,
                i = colors.green,
                v = colors.blue,
                [""] = colors.blue,
                V = colors.blue,
                c = colors.magenta,
                no = colors.red,
                s = colors.orange,
                S = colors.orange,
                [""] = colors.orange,
                ic = colors.yellow,
                R = colors.violet,
                Rv = colors.violet,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ["r?"] = colors.cyan,
                ["!"] = colors.red,
                t = colors.red,
            }
            return {
                fg = mode_colors[vim.fn.mode()],
            }
        end

        local function current_mode()
            local mode = require("lualine.utils.mode").get_mode()
            local vm_info = vim.fn.VMInfos()
            if vm_info and vm_info.status ~= nil then
                mode = "VM " .. mode
            end
            return mode
        end

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,
            check_git_workspace = function()
                local filepath = vim.fn.expand("%:p:h")
                local gitdir = vim.fn.finddir(".git", filepath .. ";")
                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
        }

        -- Config
        local config = {
            options = {
                globalstatus = true,
                -- Disable sections and component separators
                component_separators = "",
                section_separators = "",
                theme = {
                    -- We are going to use lualine_c an lualine_x as left and
                    -- right section. Both are highlighted by c theme .  So we
                    -- are just setting default looks o statusline
                    normal = {
                        c = {
                            fg = colors.fg,
                            bg = colors.bg,
                        },
                    },
                    inactive = {
                        c = {
                            fg = colors.fg,
                            bg = colors.bg,
                        },
                    },
                },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {
                        "help",
                        "netrw",
                        "alpha",
                        "fugitive",
                    },
                },
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
            winbar = {
                lualine_x = {
                    {
                        "filename",
                        path = 1,
                        color = { fg = colors.fg },
                    },
                },
            },
            inactive_winbar = {
                lualine_x = {
                    {
                        "filename",
                        path = 1,
                        color = { fg = colors.subtle },
                    },
                },
            },
            tabline = {
                lualine_a = {
                    {
                        "tabs",
                        mode = 2,
                        use_mode_colors = true,
                        tabs_color = {
                            -- Same values as the general color option can be used here.
                            active = { fg = c.fg }, -- Color for active tab.
                            inactive = { fg = c.fg_gutter }, -- Color for inactive tab.
                        },
                        fmt = function(name, ctx)
                            return string.upper(vim.fs.basename(vim.fn.getcwd(-1, ctx.tabnr)))
                        end,
                    },
                },
            },
        }

        -- Inserts a component in lualine_c at left section
        local function left(component)
            table.insert(config.sections.lualine_c, component)
        end

        -- Inserts a component in lualine_x at right section
        local function right(component)
            table.insert(config.sections.lualine_x, component)
        end

        left({
            function()
                return ""
            end,
            color = mode_color,
            padding = {
                right = 1,
            }, -- We don't need space before this
        })

        left({
            -- mode component
            current_mode,
            color = mode_color,
            padding = {
                right = 1,
            },
        })

        left({ "location" })

        left({
            "progress",
            color = {
                fg = colors.fg,
                -- gui = "bold",
            },
        })

        left({
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = {
                error = " ",
                warn = " ",
                info = " ",
            },
            diagnostics_color = {
                color_error = {
                    fg = colors.red,
                },
                color_warn = {
                    fg = colors.yellow,
                },
                color_info = {
                    fg = colors.cyan,
                },
            },
        })

        left({
            function()
                return ""
            end,
            color = mode_color,
            padding = {
                left = 1,
            }, -- We don't need space before this
        })

        -- Insert mid section. You can make any number of sections in neovim :)
        -- for lualine it's any number greater then 2
        left({
            function()
                return "%="
            end,
        })

        left({
            function()
                return ""
            end,
            color = mode_color,
            padding = {
                right = 1,
            },
        })

        left({
            function()
                return "No Active LSP / FMT"
            end,
            cond = function()
                local is_lsp_attached = #vim.lsp.get_clients({ bufnr = 0 }) > 0
                local is_fmt_attached = #require("conform").list_formatters_for_buffer(0) > 0
                return not is_lsp_attached and not is_fmt_attached
            end,
            color = { fg = colors.text },
        })

        left({
            function()
                return "LSP:"
            end,
            cond = function()
                return #vim.lsp.get_clients({ bufnr = 0 }) > 0
            end,
            color = { fg = colors.yellow },
        })

        left({
            function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })

                local lsp_names = vim.tbl_map(function(client)
                    return client.name
                end, clients)

                return table.concat(lsp_names, ", ")
            end,
            cond = function()
                return #vim.lsp.get_clients({ bufnr = 0 }) > 0
            end,
            color = { fg = colors.text },
            padding = 0,
        })

        left({
            function()
                return "&"
            end,
            cond = function()
                local is_lsp_attached = #vim.lsp.get_clients({ bufnr = 0 }) > 0
                local is_fmt_attached = #require("conform").list_formatters_for_buffer(0) > 0
                return is_lsp_attached and is_fmt_attached
            end,
            color = mode_color,
        })

        left({
            function()
                return "FMT:"
            end,
            cond = function()
                return #require("conform").list_formatters_for_buffer(0) > 0
            end,
            color = { fg = colors.yellow },
            padding = { left = 0, right = 1 },
        })

        left({
            function()
                return table.concat(require("conform").list_formatters_for_buffer(0), ", ")
            end,
            cond = function()
                return #require("conform").list_formatters_for_buffer(0) > 0
            end,
            color = { fg = colors.text },
            padding = 0,
        })

        left({
            function()
                return ""
            end,
            color = mode_color,
            padding = {
                left = 1,
            },
        })

        -- Add components to right sections

        right({
            function()
                return ""
            end,
            color = mode_color,
            padding = {
                right = 1,
            },
        })

        right({
            function()
                return "WSL"
            end,
            cond = function()
                return vim.fn.has("wsl") == 1
            end,
            color = {
                fg = colors.fg,
            },
        })
        --[[ right({
            function()
                return string.upper(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
            end,
        }) ]]

        right({
            "o:encoding", -- option component same as &encoding in viml
            fmt = string.upper, -- I'm not sure why it's upper case either ;)
            cond = conditions.hide_in_width,
            color = {
                fg = colors.green,
                -- gui = "bold",
            },
        })

        right({
            "fileformat",
            icons_enabled = true,
        })

        right({
            "FugitiveHead",
            icon = "",
            color = {
                fg = colors.violet,
                -- gui = "bold",
            },
        })

        right({
            function()
                return ""
            end,
            color = mode_color,
            padding = {
                left = 1,
            },
        })

        lualine.setup(config)
    end,
}
