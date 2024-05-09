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

        local function is_attached(predicate)
            return function()
                local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                local clients = vim.lsp.get_active_clients()
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and predicate(client) then
                        return true
                    end
                end
                return false
            end
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
            is_lsp_attached = is_attached(function(client)
                return client.name ~= "null-ls"
            end),
            is_fmt_attached = is_attached(function(client)
                return client.name == "null-ls"
            end),
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
                return not conditions.is_lsp_attached() and not conditions.is_fmt_attached()
            end,
            color = { fg = colors.text },
        })

        left({
            function()
                return "LSP:"
            end,
            cond = conditions.is_lsp_attached,
            color = { fg = colors.yellow },
        })

        left({
            function()
                local clients = vim.lsp.buf_get_clients()
                local lsps = vim.tbl_filter(function(client)
                    return client.name ~= "null-ls"
                end, clients)

                local lsp_names = vim.tbl_map(function(client)
                    return client.name
                end, lsps)

                return table.concat(lsp_names, ", ")
            end,
            cond = conditions.is_lsp_attached,
            color = { fg = colors.text },
            padding = 0,
        })

        left({
            function()
                return "&"
            end,
            cond = function()
                return conditions.is_lsp_attached() and conditions.is_fmt_attached()
            end,
            color = mode_color,
        })

        left({
            function()
                return "FMT:"
            end,
            cond = conditions.is_fmt_attached,
            color = { fg = colors.yellow },
            padding = { left = 0, right = 1 },
        })

        left({
            function()
                local fmt_names = {}
                local null_ls = require("null-ls")
                local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")

                for _, active_source in ipairs(null_ls.get_source({ filetype = buf_ft })) do
                    table.insert(fmt_names, active_source.name)
                end

                return table.concat(fmt_names, ", ")
            end,
            cond = conditions.is_fmt_attached,
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
            "branch",
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
