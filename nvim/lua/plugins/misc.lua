return {

	{
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = {
			"smoka7/hydra.nvim",
		},
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },

		keys = {
			{
				mode = { "v", "n" },
				"<Leader>m",
				"<cmd>MCstart<cr>",
				desc = "Create a selection for selected text or word under the cursor",
			},
		},
		config = function()
			require("multicursors").setup({
				hint_config = false,
			})
		end,
	},
	--[[ {
		"mg979/vim-visual-multi",
		branch = "master",
		config = function()
			vim.keymap.set("n", "<C-n>", "<Plug>(VM-Find-Under)")
			vim.keymap.set("n", "<C-m>", "<Plug>(VM-Skip-Region)")
			vim.keymap.set("n", "<C-Up>", "<Plug>(VM-Add-Cursor-Up)")
			vim.keymap.set("n", "<C-Down>", "<Plug>(VM-Add-Cursor-Down)")
		end,
	}, ]]

	-- Color Code Highlight #069420
	{
		"uga-rosa/ccc.nvim",
		config = function()
			require("ccc").setup({
				highlighter = {
					auto_enable = true,
					lsp = true,
				},
			})
		end,
	},
	-- Auto Slash Comment
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
		config = function()
			require("Comment").setup()
			vim.api.nvim_set_keymap("n", "<C-/>", "gcc", { noremap = false })
			vim.api.nvim_set_keymap("v", "<C-/>", "gb<Esc>", { noremap = false })
			vim.api.nvim_set_keymap("v", "<C-?>", "gc<Esc>", { noremap = false })
			vim.api.nvim_set_keymap("i", "<C-/>", "<Esc>gcci", { noremap = false })
		end,
	},
	-- Auto Pairs
	--[[ {
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- Equivalent to setup({}) function
	}, ]]
	{
		"RaafatTurki/hex.nvim",
		config = function()
			require("hex").setup({})
		end,
	},
}
