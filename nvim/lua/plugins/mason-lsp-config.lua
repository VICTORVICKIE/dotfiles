return { --- Mason
{
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
        require("mason").setup({
            registries = {"github:nvim-java/mason-registry", "github:mason-org/mason-registry"}
        })
    end
}, -- Mason LSP Config
{
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
        auto_install = true
    }
}, {
    "nvim-java/nvim-java",
    dependencies = {"nvim-java/lua-async-await", "nvim-java/nvim-java-core", "nvim-java/nvim-java-test",
                    "nvim-java/nvim-java-dap", "mfussenegger/nvim-dap"},
    config = function()
        require("java").setup()
    end
}, -- LSP Config
{
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")

        lspconfig.tsserver.setup({
            capabilities = capabilities
        })
        lspconfig.lua_ls.setup({
            capabilities = capabilities
        })
        lspconfig.pyright.setup({
            capabilities = capabilities
        })
        lspconfig.svelte.setup({
            capabilities = capabilities
        })
        lspconfig.rust_analyzer.setup({
            capabilities = capabilities
        })
        lspconfig.gopls.setup({
            capabilities = capabilities
        })
        lspconfig.clangd.setup({
            capabilities = capabilities
        })
        lspconfig.html.setup({
            capabilities = capabilities
        })
        lspconfig.tailwindcss.setup({
            capabilities = capabilities
        })
        lspconfig.jdtls.setup({
            capabilities = capabilities
        })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end
}}
