return {
    "nvim-neo-tree/neo-tree.nvim",
    priority = 998,
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    config = function()
        require("neo-tree").setup({
            window = {
                mappings = {
                    ["<space>"] = "none",
                    ["<leader>sh"] = "open_split",
                    ["<leader>sv"] = "open_vsplit",
                    ["s"] = "none",
                    ["S"] = "none",
                },
            },
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                },
            },
        })
        vim.keymap.set({ "n", "i" }, "<C-b>", ":Neotree filesystem toggle right<CR>", { silent = true })
        --[[ vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                vim.cmd("Neotree filesystem toggle right")
                vim.cmd("wincmd h")
            end,
        }) ]]
    end,
}
