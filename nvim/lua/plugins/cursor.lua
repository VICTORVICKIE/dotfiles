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
            ["Find Under"] = "<C-d>",
            ["Find Subword Under"] = "<C-d>",
            ["Skip Region"] = "<C-s>",
            ["Select h"] = "<S-Left>",
            ["Select l"] = "<S-Right>",
            ["Add Cursor Up"] = "<C-Up>",
            ["Add Cursor Down"] = "<C-Down>",
            ["Mouse Cursor"] = "<C-LeftMouse>",
            ["Mouse Column"] = "<C-RightMouse>",
        }
        vim.g.VM_custom_remaps = {
            ["<C-c>"] = "<Esc>",
        }
        vim.g.VM_highlight_matches = ""
    end,
}
