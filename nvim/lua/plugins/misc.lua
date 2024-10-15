return {
    { "lewis6991/gitsigns.nvim", opts = {} },
    { "szw/vim-maximizer", cmd = "MaximizerToggle" },
    { "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
    { "RaafatTurki/hex.nvim", event = "VeryLazy", opts = {} },
    { "eandrju/cellular-automaton.nvim", cmd = "CellularAutomaton" },
    { "inkarkat/vim-AdvancedSorters", dependencies = "inkarkat/vim-ingo-library" },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
}
