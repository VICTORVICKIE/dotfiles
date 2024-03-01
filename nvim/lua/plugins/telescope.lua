return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			local conf = require("telescope.config").values

			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end
				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					})
					:find()
			end

			harpoon:setup()

			vim.keymap.set("n", "<leader>th", function()
				toggle_telescope(harpoon:list())
			end, { desc = "harpoon" })
			vim.keymap.set("n", "<A-h>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)
			vim.keymap.set("n", "<A-a>", function()
				harpoon:list():append()
			end)
			vim.keymap.set("n", "<A-1>", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<A-2>", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<A-3>", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<A-4>", function()
				harpoon:list():select(4)
			end)
		end,
	},
	-- Telescope UI Select
	{ "nvim-telescope/telescope-ui-select.nvim" },
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = { require("telescope.themes").get_dropdown({}) },
				},
			})

			require("telescope").load_extension("ui-select")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<Leader>tf", builtin.find_files, { desc = "file" })
			vim.keymap.set("n", "<Leader>tg", builtin.live_grep, { desc = "grep" })
		end,
	},
}
