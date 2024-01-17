return {
	{
		"mg979/vim-visual-multi",
		branch = "master",
		init = function()
			vim.g.VM_default_mappings = 0
			vim.g.VM_set_statusline = 0
			vim.g.VM_silent_exit = 1
			vim.g.VM_quit_after_leaving_insert_mode = 1
			vim.g.VM_show_warnings = 0
			-- vim.g.VM_highlight_matches = ""
		end,
		config = function()
			vim.keymap.set("n", "<C-n>", "<Plug>(VM-Find-Under)")
			vim.keymap.set("n", "<C-m>", "<Plug>(VM-Skip-Region)")
			vim.keymap.set("n", "<C-Up>", "<Plug>(VM-Add-Cursor-Up)")
            vim.keymap.set("n", "<C-Down>", "<Plug>(VM-Add-Cursor-Down)")
		end,
	},

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
	{
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({})
		end,
	},
	{
		"RaafatTurki/hex.nvim",
		config = function()
			require("hex").setup({})
		end,
	},
}
