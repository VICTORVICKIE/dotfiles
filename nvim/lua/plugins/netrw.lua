return {
    "prichrd/netrw.nvim",
    config = function()
        vim.g.netrw_keepdir = 0
        vim.g.netrw_liststyle = 3
        require("netrw").setup({
            icons = {
                symlink = "", -- Symlink icon (directory and file)
                directory = "", -- Directory icon
                file = "", -- File icon
            },
            use_devicons = true, -- Uses nvim-web-devicons if true, otherwise use the file icon specified above
            mappings = {}, -- Custom key mappings
        })
    end,
}
