return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    priority = 998,
    dependencies = {
        -- NOTE: Must be loaded before dependants
        { "williamboman/mason.nvim", config = true },
    },
    lazy = false,
    config = function()
        require("mason-tool-installer").setup({
            ensure_installed = require("tools").ensure_installed,
            auto_update = true,
        })
    end,
}
