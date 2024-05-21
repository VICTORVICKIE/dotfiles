-- Auto Command
local victor_group = vim.api.nvim_create_augroup("victor", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
    group = victor_group,
    callback = function()
        if os.getenv("DEV") then
            vim.cmd("cd $DEV")
        end
    end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
    group = victor_group,
    callback = function()
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
    if vim.fn.executable("wt.exe") == 0 then
        vim.api.nvim_echo({ { "Windows Terminal is not installed.", "ErrorMsg" } }, true, {})
        return
    end

    local job_id = 0
    if vim.fn.has("win32") and string.find(opts.args, "wsl") and vim.fn.executable("wsl.exe") then
        job_id = vim.fn.jobstart({ "wt.exe", "-w", "0", "nt", "-p", "Ubuntu", "-d", vim.fn.getcwd(), "wsl" })
    elseif vim.fn.has("wsl") and string.find(opts.args, "wsl") then
        job_id = vim.fn.jobstart({ "wt.exe", "-w", "0", "nt", "-p", "Ubuntu", "-d", vim.fn.getcwd(), "wsl" })
    else
        job_id = vim.fn.jobstart({ "wt.exe", "-w", "0", "nt", "-d", vim.fn.getcwd() })
    end

    if job_id <= 0 then
        vim.api.nvim_echo({ { "Unable to launch Windows Terminal.", "ErrorMsg" } }, true, {})
        return
    end
end, {
    nargs = "?",
    complete = function()
        return { "wsl" }
    end,
})

vim.api.nvim_create_user_command("RunNeovide", function(opts)
    if vim.fn.executable("neovide") == 0 and vim.fn.executable("neovide.exe") == 0 then
        vim.api.nvim_echo({ { "Neovide is not installed.", "ErrorMsg" } }, true, {})
        return
    end

    local job_id = 0
    if vim.fn.has("win32") and string.find(opts.args, "wsl") and vim.fn.executable("wsl.exe") then
        job_id = vim.fn.jobstart({ "neovide.exe", "--wsl" }, { detach = true })
    elseif vim.fn.has("wsl") and vim.fn.executable("neovide") == 0 then
        job_id = vim.fn.jobstart({ "neovide.exe" }, { detach = true })
    else
        job_id = vim.fn.jobstart({ "neovide" }, { detach = true })
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
    local bufinfos = vim.fn.getbufinfo({ buflisted = true })
    local hidden = 0
    vim.tbl_map(function(bufinfo)
        if bufinfo.changed == 0 and (not bufinfo.windows or #bufinfo.windows == 0) then
            vim.api.nvim_buf_delete(bufinfo.bufnr, { force = true, unload = false })
            hidden = hidden + 1
        end
    end, bufinfos)
    -- print(("Deleted %d Hidden Buffers"):format(hidden))
end, { desc = "Wipeout all buffers not shown in a window" })
