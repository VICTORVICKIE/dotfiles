return {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        local servers = {
            stylua = {},
            gofmt = {},
            prettier = {
                extra_args = {
                    "--bracket-same-line",
                    "--tab-width",
                    "4",
                    "--print-width",
                    "120",
                    "--quote-props",
                    "preserve",
                },
            },
            black = {},
            isort = {},
            clang_format = { extra_args = { "-style={BasedOnStyle: LLVM, IndentWidth: 4}" } },
        }
        local ensure_installed = vim.tbl_keys(servers)

        local sources = {}
        for server_name, server_args in pairs(servers) do
            local source = null_ls.builtins.formatting[server_name]
            if source then
                table.insert(sources, source.with({ extra_args = server_args.extra_args or {} }))
            end
        end

        require("mason-null-ls").setup({
            ensure_installed = ensure_installed,
            automatic_installation = true,
        })

        null_ls.setup({
            debug = true,
            sources = sources,
        })
        vim.keymap.set("n", "<leader>lf", function()
            vim.lsp.buf.format({
                filter = function(client)
                    return client.name == "null-ls"
                end,
            })
            vim.cmd("retab")
        end, { desc = "LSP: Code Format" })
    end,
}
