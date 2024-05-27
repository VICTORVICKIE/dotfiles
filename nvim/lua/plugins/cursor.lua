return {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
        vim.g.VM_default_mappings = 0
        vim.g.VM_set_statusline = 0
        vim.g.VM_silent_exit = 1
        vim.g.VM_quit_after_leaving_insert_mode = 1
        vim.g.VM_show_warnings = 0
        vim.g.VM_maps = {
            ["Undo"] = "u",
            ["Redo"] = "<C-r>",
        }
        vim.g.VM_custom_remaps = {
            ["<C-c>"] = "<Esc>",
        }
        vim.g.VM_highlight_matches = ""

    end,
    config = function()
        vim.keymap.set("n", "<C-d>", "<Plug>(VM-Find-Under)")
        vim.keymap.set("v", "<C-d>", "<Plug>(VM-Find-Subword-Under)")
        vim.keymap.set("n", "<C-s>", "<Plug>(VM-Skip-Region)")
        vim.keymap.set("n", "<C-Up>", "<Plug>(VM-Add-Cursor-Up)")
        vim.keymap.set("n", "<C-Down>", "<Plug>(VM-Add-Cursor-Down)")
        vim.keymap.set("n", "<S-Left>", "<Plug>(VM-Select-h)")
        vim.keymap.set("n", "<S-Right>", "<Plug>(VM-Select-l)")
        vim.keymap.set("n", "<C-LeftMouse>", "<Plug>(VM-Mouse-Cursor)")
        vim.keymap.set("n", "<C-RightMouse>", "<Plug>(VM-Mouse-Column)")
    end,
}
