return {
    {
        "tpope/vim-fugitive",
        dependencies = {
            "jecaro/fugitive-difftool.nvim",
        },
        config = function()
            vim.api.nvim_create_user_command("Gcfir", require("fugitive-difftool").git_cfir, {})
            vim.api.nvim_create_user_command("Gcla", require("fugitive-difftool").git_cla, {})
            vim.api.nvim_create_user_command("Gcn", require("fugitive-difftool").git_cn, {})
            vim.api.nvim_create_user_command("Gcp", require("fugitive-difftool").git_cp, {})
            vim.api.nvim_create_user_command("Gcc", require("fugitive-difftool").git_cc, {})
        end,
    },
}
