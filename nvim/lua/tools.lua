local function python_path()
    local default_exepath = vim.fn.exepath("python3") or vim.fn.exepath("python")

    if vim.fn.isdirectory("venv") then
        local exepath = vim.fs.find({ "python", "python.exe" }, { path = "venv" })[1]
        return exepath or default_exepath
    end

    return default_exepath
end

local formatters = {
    stylua = {
        name = "stylua",
        filetypes = { "lua" },
        args = {
            "--indent-type",
            "Spaces",
        },
    },
    gofmt = {
        name = "gofmt",
        external = true,
        filetypes = { "go" },
    },
    prettier = {
        name = "prettier",
        filetypes = { "javascript", "typescript", "html", "css", "json", "astro" },
        args = {
            "--bracket-same-line",
            "--tab-width",
            "4",
            "--print-width",
            "120",
            "--quote-props",
            "preserve",
        },
    },
    latexindent = {
        name = "latexindent",
        filetypes = { "tex" },
    },
    -- isort = {
    --     name = "isort",
    --     filetypes = { "python" },
    -- },
    -- black = {
    --     name = "black",
    --     filetypes = { "python" },
    --     args = {
    --         "--line-length",
    --         "79",
    --     },
    -- },
    clang_format = {
        name = "clang-format",
        filetypes = { "c", "cpp" },
        args = { "-style={IndentWidth: 4, AllowShortIfStatementsOnASingleLine: true, BreakBeforeBraces: Stroustrup}" },
    },
    xmlformatter = {
        name = "xmlformatter",
        filetypes = { "xml" },
    },
}

local lang_servers = {
    rust_analyzer = {
        name = "rust_analyzer",
    },
    jdtls = {
        name = "jdtls",
        root_dir = require("jdtls.setup").find_root({ "mvnw", "gradlew", ".git" }),
    },
    vtsls = {
        name = "vtsls",
    },
    --◍ css-lsp cssls (keywords: css, scss, less)
    --◍ css-variables-language-server css_variables (keywords: css, scss, less)
    --
    css_variables = {
        name = "css-variables-language-server",
    },
    cssls = {
        name = "css-lsp",
    },
    tailwindcss = {
        name = "tailwindcss",
    },
    svelte = {
        name = "svelte",
        settings = {
            svelte = { plugin = { svelte = { format = { config = { printWidth = 120, bracketSameLine = true } } } } },
        },
    },
    ruff = {
        name = "ruff",
        config = {
            trace = "messages",
            init_options = {
                settings = {
                    logLevel = "debug",
                },
            },
        },
    },
    pyright = {
        name = "pyright",
        before_init = function(_, config)
            local pythonPath = python_path()
            config.settings.python.pythonPath = pythonPath
        end,
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                },
            },
        },
        -- settings = {
        --     python = {
        --         pythonPath = python_path(),
        --     },
        -- },
    },
    html = {
        name = "html",
    },
    gdscript = {
        name = "gopls",
        external = true,
    },
    gopls = {
        name = "gopls",
    },
    lua_ls = {
        name = "lua_ls",
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

return {
    lang_servers = lang_servers,
    formatters = formatters,
    ensure_installed = vim.list_extend(
        vim.iter(lang_servers)
            :map(function(k, v)
                if not v.external then
                    return v.name
                end
            end)
            :totable(),
        vim.iter(formatters)
            :map(function(k, v)
                if not v.external then
                    return v.name
                end
            end)
            :totable()
    ),
}
