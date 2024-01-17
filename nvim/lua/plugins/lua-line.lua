return {
	"nvim-lualine/lualine.nvim",
	enabled = true,
	config = function()
		local lualine = require("lualine")
		local rp = require("rose-pine.palette")
		local colors = {
			bg = rp.nc,
			fg = rp.text,
			yellow = rp.gold,
			cyan = rp.foam,
			darkblue = "#286983",
			green = "#56949F",
			orange = "#EA9D34",
			violet = rp.iris,
			magenta = rp.rose,
			blue = rp.pine,
			red = rp.love,
			none = rp.base,
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
						"neo-tree",
						"alpha",
					},
				},
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- These will be filled later
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
			winbar = {
				lualine_a = { "diagnostics" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = { "filename" },
				lualine_y = {},
				lualine_z = {},
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
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

		-- left({ get_name, cond = is_active })
		--[[ left({
            -- filesize component
            "filesize",
            cond = conditions.buffer_not_empty,
        }) ]]

		--[[ left({
            "filename",
            cond = conditions.buffer_not_empty,
            color = {
                fg = colors.magenta,
                gui = "bold",
            },
        }) ]]

		left({ "location" })

		left({
			"progress",
			color = {
				fg = colors.fg,
				gui = "bold",
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
			-- Lsp server name .
			function()
				local msg = "No Active Lsp "
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return msg
				end
				local lsp = {}
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						table.insert(lsp, client.name)
					end
				end
				return table.concat(lsp, ", ") .. " "
			end,
			icon = " LSP:",
			color = {
				fg = rp.text,
				gui = "bold",
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
				gui = "bold",
			},
		})

		right({
			"fileformat",
			fmt = string.upper,
			icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
			color = {
				fg = colors.green,
				gui = "bold",
			},
		})

		right({
			"branch",
			icon = "",
			color = {
				fg = colors.violet,
				gui = "bold",
			},
		})

		right({
			"diff",
			-- Is it me or the symbol for modified us really weird
			symbols = {
				added = "[+] ",
				modified = "[~] ",
				removed = "[-] ",
			},
			diff_color = {
				added = {
					fg = colors.green,
				},
				modified = {
					fg = colors.orange,
				},
				removed = {
					fg = colors.red,
				},
			},
			cond = conditions.hide_in_width,
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
