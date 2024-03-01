return { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            build = (function()
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
        },
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lua",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        luasnip.config.setup({})

        cmp.setup({
            window = {
                documentation = cmp.config.window.bordered(),
                completion = cmp.config.window.bordered(),
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = "menu,menuone,noinsert" },
            mapping = cmp.mapping.preset.insert({
                ["<Down>"] = cmp.mapping(function(fallback)
                    cmp.close()
                    fallback()
                end, { "i" }),
                ["<Up>"] = cmp.mapping(function(fallback)
                    cmp.close()
                    fallback()
                end, { "i" }),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete({}),
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),
            }),
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "nvim_lua", include_deprecated = true },
                { name = "path" },
                { name = "buffer", keyword_length = 5 },
            },

            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = function()
                        return math.floor(0.33 * vim.o.columns)
                    end,
                    ellipsis_char = "...",
                    show_labelDetails = true,
                    menu = {
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snip]",
                        nvim_lua = "[Lua]",
                        path = "[Path]",
                    },
                }),
            },
        })
    end,
}
