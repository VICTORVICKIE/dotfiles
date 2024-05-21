return { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mfussenegger/nvim-jdtls",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        {
            "j-hui/fidget.nvim",
            opts = {
                notification = {
                    window = {
                        border = "single", -- Border around the notification window
                    },
                },
            },
        },
    },
    config = function()
        local telescope_builtin = require("telescope.builtin")
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", {
                clear = true,
            }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, {
                        buffer = event.buf,
                        desc = desc,
                    })
                end

                map("<leader>ld", telescope_builtin.lsp_definitions, "goto definition")

                map("<leader>lD", vim.lsp.buf.declaration, "goto declaration")

                map("<leader>lr", telescope_builtin.lsp_references, "goto references")

                map("<leader>lR", vim.lsp.buf.rename, "symbol rename")

                map("<leader>li", telescope_builtin.lsp_implementations, "goto implementation")

                map("<leader>ls", telescope_builtin.lsp_document_symbols, "symbols document")

                map("<leader>lw", telescope_builtin.lsp_dynamic_workspace_symbols, "symbols workspace")

                map("<leader>la", function()
                    vim.lsp.buf.code_action({
                        context = {
                            only = { "quickfix", "refactor", "source" },
                        },
                    })
                end, "Code Action")

                map("<leader>lt", telescope_builtin.lsp_type_definitions, "type definition")

                map("<leader>lh", vim.lsp.buf.hover, "hover documentation")

                vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                    border = "rounded",
                })

                vim.diagnostic.config({
                    float = {
                        border = "rounded",
                    },
                })

                map("[d", vim.diagnostic.goto_prev, "Go to previous [D]iagnostic message")
                map("]d", vim.diagnostic.goto_next, "Go to next [D]iagnostic message")
                map("<leader>de", vim.diagnostic.open_float, "Show diagnostic [E]rror messages")
                map("<leader>dq", vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list")

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        local function python_path()
            local default_exepath = vim.fn.exepath("python3") or vim.fn.exepath("python")

            if vim.fn.isdirectory("venv") then
                local exepath = vim.fs.find({ "python", "python.exe" }, { path = "venv" })[1]
                return exepath or default_exepath
            end

            return default_exepath
        end

        local servers = {
            rust_analyzer = {},
            jdtls = {},
            tsserver = {},
            svelte = {},
            pyright = {
                settings = {
                    python = {
                        pythonPath = python_path(),
                    },
                },
            },
            html = {},
            gopls = {},
            lua_ls = {
                -- cmd = {...},
                -- filetypes { ...},
                -- capabilities = {},
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            disable = { "missing-fields" },
                        },
                        workspace = {
                            checkThirdParty = false,
                            -- library = {
                            --     "${3rd}/luv/library",
                            --     unpack(vim.api.nvim_get_runtime_file("", true)),
                            -- },
                            library = { "${3rd}/luv/library", vim.env.VIMRUNTIME },
                        },
                    },
                },
            },
        }

        local ensure_installed = vim.tbl_keys(servers)

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = ensure_installed,
            automatic_installation = true,

            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    require("lspconfig")[server_name].setup({
                        cmd = server.cmd,
                        settings = server.settings,
                        filetypes = server.filetypes,
                        root_dir = vim.loop.cwd,
                        capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
                    })
                end,
            },
        })
    end,
}
