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
        filetypes = { "go" },
    },
    prettierd = {
        name = "prettierd",
        filetypes = { "javascript", "typescript", "svelte", "html", "css", "json" },
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
    isort = {
        name = "isort",
        filetypes = { "python" },
    },
    black = {
        name = "black",
        filetypes = { "python" },
        args = {
            "--line-length",
            "79",
        },
    },

    clang_format = {
        name = "clang-format",
        filetypes = { "c", "cpp" },
        args = { "-style={BasedOnStyle: LLVM, IndentWidth: 4}" },
    },
}

local lang_servers = {
    rust_analyzer = {
        name = "rust_analyzer",
    },
    jdtls = {
        name = "jdtls",
    },
    tsserver = {
        name = "tsserver",
    },
    tailwindcss = {
        name = "tailwindcss",
    },
    svelte = {
        name = "svelte",
    },
    pyright = {
        name = "pyright",
        settings = {
            python = {
                pythonPath = python_path(),
            },
        },
    },
    html = {
        name = "html",
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
        vim.tbl_map(function(v)
            return v.name
        end, lang_servers),
        vim.tbl_map(function(v)
            return v.name
        end, formatters)
    ),
}
