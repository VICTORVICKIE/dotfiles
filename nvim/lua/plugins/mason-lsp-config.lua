return {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        "mfussenegger/nvim-jdtls",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        {
            "j-hui/fidget.nvim",
            tag = "v1.0.0",
        },
    },
    config = function()
        require("fidget").setup()
        require("mason").setup()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "rust_analyzer", "jdtls", "tsserver", "pyright" },
            auto_install = true,
            handlers = {
                function(server) -- default handler (optional)
                    require("lspconfig")[server].setup({ capabilities = capabilities })
                end,
            },
        })
        vim.keymap.set("n", "<leader>gh", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
        vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, {})
        vim.keymap.set("n", "<leader>gn", vim.lsp.buf.rename, {})
    end,
}
