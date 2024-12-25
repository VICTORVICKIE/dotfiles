return {
    {
        "tpope/vim-fugitive",
        -- config = function()
        --     vim.api.nvim_create_user_command("G", function(opts)
        --         local args = opts.args
        --         vim.cmd("vertical Git " .. args)
        --     end, {
        --         nargs = "*",
        --     })
        --     vim.keymap.set("n", "<leader>gf", vim.cmd.G)
        -- end,
    },
}
