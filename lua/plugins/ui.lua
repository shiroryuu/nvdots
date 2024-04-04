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
		"folke/zen-mode.nvim",
		dependencies = { "folke/twilight.nvim" },
		config = function()
			vim.keymap.set("n", "<Leader>tz", function()
				require("zen-mode").setup({
					window = {
						backdrop = 1,
						width = 120,
						height = 1,
						options = {
							signcolumn = "no",
							relativenumber = false,
						},
					},
				})
			end, { desc = "Toggle Zen mode" })
		end,
	},
}
