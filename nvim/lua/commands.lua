-- Auto Command
local victor_group = vim.api.nvim_create_augroup("victor", { clear = true })

local fn = vim.fn

vim.api.nvim_create_autocmd("VimLeavePre", {
    group = victor_group,
    callback = function()
        vim.lsp.stop_client(vim.lsp.get_clients())
        vim.cmd("DelHidBufs")
        vim.cmd("SessionSave")
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = victor_group,
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_user_command("RunWT", function(opts)
    -- if fn.executable("wt.exe") == 0 then
    --     vim.api.nvim_echo({ { "Windows Terminal is not installed.", "ErrorMsg" } }, true, {})
    --     return
    -- end

    local job_id = 0

    local wt = { "cmd", "/c", "wt.exe", "--window", "0", "new-tab" }
    if opts.args:find("wsl") ~= nil and fn.executable("wsl.exe") then
        job_id = fn.jobstart(vim.list_extend(wt, { "-p", "Ubuntu", "-d", fn.getcwd() }))
    elseif opts.args:find("pwsh") ~= nil and fn.executable("pwsh.exe") == 1 then
        if fn.has("win32") == 1 then
            job_id = fn.jobstart(vim.list_extend(wt, { "-p", "PowerShell", "-d", fn.getcwd() }))
        elseif fn.has("wsl") == 1 then
            local cwd = fn.system({ "wslpath", "-m", fn.getcwd() }):gsub("%s+", "")
            job_id = fn.jobstart(vim.list_extend(wt, { "-p", "PowerShell", "-d", cwd }))
        end
    else
        assert(false, "Unreachable")
    end

    if job_id <= 0 then
        vim.api.nvim_echo({ { "Unable to launch Windows Terminal.", "ErrorMsg" } }, true, {})
        return
    end
end, {
    nargs = 1,
    complete = function()
        return { "pwsh", "wsl" }
    end,
})

vim.api.nvim_create_user_command("RunNeovide", function(opts)
    if fn.executable("neovide") == 0 and fn.executable("neovide.exe") == 0 then
        vim.api.nvim_echo({ { "Neovide is not installed.", "ErrorMsg" } }, true, {})
        return
    end

    local job_id = 0
    if fn.has("win32") and string.find(opts.args, "wsl") and fn.executable("wsl.exe") then
        job_id = fn.jobstart({ "neovide.exe", "--wsl" }, { detach = true })
    elseif fn.has("wsl") and fn.executable("neovide") == 0 then
        job_id = fn.jobstart({ "neovide.exe" }, { detach = true })
    else
        job_id = fn.jobstart({ "neovide" }, { detach = true })
    end

    if job_id <= 0 then
        vim.api.nvim_echo({ { "Unable to launch Neovide.", "ErrorMsg" } }, true, {})
        return
    end

    if string.find(opts.args, "relaunch") then
        vim.cmd("wqall")
    end
end, {
    nargs = "*",
    complete = function()
        return { "wsl", "relaunch" }
    end,
})

vim.api.nvim_create_user_command("DelHidBufs", function()
    local bufinfos = fn.getbufinfo({ buflisted = true })
    local hidden = 0
    vim.tbl_map(function(bufinfo)
        if bufinfo.changed == 0 and (not bufinfo.windows or #bufinfo.windows == 0) then
            vim.api.nvim_buf_delete(bufinfo.bufnr, { force = true, unload = false })
            hidden = hidden + 1
        end
    end, bufinfos)
    -- print(("Deleted %d Hidden Buffers"):format(hidden))
end, { desc = "Wipeout all buffers not shown in a window" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function(args)
        local jdtls_cmd = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
        if vim.fn.has("win32") == 1 then
            jdtls_cmd = jdtls_cmd .. ".cmd"
        end
        local config = {
            cmd_env = {
                JAVA_HOME = vim.fn.system("jabba which microsoft@21"):gsub("%s+", ""),
            },
            cmd = {
                jdtls_cmd,
                "-data",
                os.getenv("DEV") .. ".java-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
            },
            root_dir = require("jdtls.setup").find_root({ "pom.xml", "build.gradle", "mvnw", "gradlew", ".git" }),
        }
        print(config.root_dir)
        require("jdtls").start_or_attach(config)
    end,
})
