return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {},
	},
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        "folke/zen-mode.nvim",
        dependencies = { "folke/twilight.nvim" },
        keys = {
            { "<Leader>tz", "<Cmd>ZenMode<CR>", { desc = "Toggle Zen mode" } }
        },
        opts = {
            window = {
                backdrop = 1,
                width = 120,
                height = 1,
                options = {
                    signcolumn = "no",
                    relativenumber = false,
                },
            },
        },
        config = function(_, opts)
            require("zen-mode").setup(opts)
        end,
    },
}
