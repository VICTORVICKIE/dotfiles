return {
    "stevearc/conform.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
        local conform = require("conform")
        local servers = require("tools").formatters

        local formatters_by_ft = vim.defaulttable(function()
            return {}
        end)

        for formatter in vim.iter(vim.tbl_values(servers)) do
            for filetype in vim.iter(formatter.filetypes) do
                table.insert(formatters_by_ft[filetype], formatter.name)
            end
            conform.formatters[formatter.name] = {
                prepend_args = formatter.args,
            }
        end

        conform.setup({
            formatters_by_ft = formatters_by_ft,
            log_level = vim.log.levels.INFO,
        })

        vim.keymap.set({ "n", "v" }, "<leader>lf", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            })
        end, { desc = "LSP: Code Format" })
    end,
}
