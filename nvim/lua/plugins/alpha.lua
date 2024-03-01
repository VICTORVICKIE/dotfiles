return {

	"goolord/alpha-nvim",
    event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	priority = 999,
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[        I Use                                                          ]],
			[[                                                                     ]],
			[[       ████ ██████           █████      ██                     ]],
			[[      ███████████             █████                             ]],
			[[      █████████ ███████████████████ ███   ███████████   ]],
			[[     █████████  ███    █████████████ █████ ██████████████   ]],
			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
			[[                                                                       ]],
			[[                                                                   BTW ]],
			[[                                                                       ]],
		}

		dashboard.section.buttons.val = {}

		dashboard.section.footer.val = "Victor Vickie"

		dashboard.section.footer.opts.hl = "Type"
		dashboard.section.header.opts.hl = "Include"
		-- dashboard.section.buttons.opts.hl = "Keyword"
		dashboard.opts.opts.noautocmd = true
		alpha.setup(dashboard.opts)
	end,
}
