--- This folder is for plugins that should be run
--- regardless of whether nvim is running standalone
--- or embedded inside another application e.g. vscode.

return {
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },
}