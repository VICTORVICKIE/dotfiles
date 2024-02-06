return {
    {
        "mg979/vim-visual-multi",
        branch = "master",
        init = function()
            vim.g.VM_default_mappings = 0
            vim.g.VM_set_statusline = 0
            vim.g.VM_silent_exit = 1
            vim.g.VM_quit_after_leaving_insert_mode = 1
            vim.g.VM_show_warnings = 0
            -- vim.g.VM_highlight_matches = ""
        end,
        config = function()
            vim.keymap.set("n", "<C-n>", "<Plug>(VM-Find-Under)")
            vim.keymap.set("n", "<C-m>", "<Plug>(VM-Skip-Region)")
            vim.keymap.set("n", "<C-Up>", "<Plug>(VM-Add-Cursor-Up)")
            vim.keymap.set("n", "<C-Down>", "<Plug>(VM-Add-Cursor-Down)")
        end,
    },
}
