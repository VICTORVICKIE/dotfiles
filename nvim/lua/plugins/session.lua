return {
	{
		"olimorris/persisted.nvim",
		config = function()
			local persisted = require("persisted")
			require("telescope").load_extension("persisted")
			vim.keymap.set("n", "<Leader>ts", function()
				vim.cmd("Telescope persisted")
			end, { desc = "session" })

			persisted.setup({
				ignored_dirs = { "$DEV" },
                autosave = true,
				should_autosave = function()
					local excluded_filetypes = {
						"alpha",
						"mason",
						"lazy",
						"",
					}

					for _, excluded_ft in ipairs(excluded_filetypes) do
						if vim.bo.filetype == excluded_ft then
							return false
						end
					end

					return true
				end,
			})
			local group = vim.api.nvim_create_augroup("PersistedHooks", {})

			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = "PersistedTelescopeLoadPre",
				group = group,
				callback = function()
					vim.cmd("DelHidBufs") -- ../commands.lua
					persisted.save({ session = vim.g.persisted_loaded_session })
					vim.cmd("%bd!")
				end,
			})
			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = "PersistedTelescopeLoadPost",
				group = group,
				callback = function(session)
					vim.schedule(function()
						vim.cmd("cd " .. session.data.dir_path)
						print("Loaded session: " .. session.data.name)
					end)
				end,
			})
		end,
	},
	{
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({
				trigger_events = { "TextChanged" },
				condition = function(buf)
					local fn = vim.fn
					local utils = require("auto-save.utils.data")

					if
						fn.getbufvar(buf, "&modifiable") == 1
						and utils.not_in(fn.getbufvar(buf, "&filetype"), { "harpoon" })
					then
						return true -- met condition(s), can save
					end
					return false -- can't save
				end,
			})
		end,
	},
}
