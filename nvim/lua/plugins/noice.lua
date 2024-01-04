return {
	"folke/noice.nvim",
	enabled = false,
    event = "VeryLazy",
	opts = {},
	dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	config = function()
		local notify = require("notify")
		notify.setup({
			fps = 144,
			render = "simple",
			timeout = 1000,
			top_down = false,
		})

		require("noice").setup({
			cmdline = {
				format = {
					search_and_replace = {
						kind = "replace",
						pattern = "^:%%?s/",
						icon = " ",
						lang = "regex",
					},
					search_and_replace_range = {
						kind = "replace",
						pattern = "^:'<,'>%%?s/",
						icon = " ",
						lang = "regex",
					},
				},
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				long_message_to_split = true,
				lsp_doc_border = true,
			},
			throttle = 1000 / 120,
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = {
						skip = true,
					},
				},
			},
			views = {
				cmdline_popup = {
					position = { row = "50%", col = "50%" },
					size = { width = "auto", height = "auto" },
				},
				popupmenu = {
					position = { row = "50%", col = "50%" },
					size = { width = 60, height = 10 },
					border = { style = "rounded", padding = { 0, 1 } },
					win_options = {
						winhighlight = {
							Normal = "Normal",
							FloatBorder = "DiagnosticInfo",
						},
					},
				},
			},
		})
	end,
}
