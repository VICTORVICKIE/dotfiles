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
        vim.cmd("LspStop")
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = victor_group,
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_user_command("WinTerm", function()
    if vim.fn.has("win32") == 1 then
        vim.fn.jobstart({ "cmd.exe", "/c", "wt", "-w", "0", "nt", "-d", vim.fn.getcwd() })
    elseif os.getenv("WSL_DISTRO_NAME") then
        vim.fn.jobstart({ "cmd.exe", "/c", "wt", "-w", "0", "nt", "-d", vim.fn.getcwd(), "wsl" })
    end
end, {})

vim.api.nvim_create_user_command("DelHidBufs", function()
    local bufinfos = vim.fn.getbufinfo({ buflisted = true })
    local hidden = 0
    vim.tbl_map(function(bufinfo)
        if bufinfo.changed == 0 and (not bufinfo.windows or #bufinfo.windows == 0) then
            vim.api.nvim_buf_delete(bufinfo.bufnr, { force = true, unload = false })
            hidden = hidden + 1
        end
    end, bufinfos)
    print(("Deleted %d Hidden Buffers"):format(hidden))
end, { desc = "Wipeout all buffers not shown in a window" })
