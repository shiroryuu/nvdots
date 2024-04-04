return {
	{
		"lewis6991/gitsigns.nvim",
		enabled = vim.fn.executable("git") == 1,
		-- TODO: Add LazyFile event
		-- NOTE: It uses a shortcut to event = { "BufReadPost", "BufWritePost", "BufNewFile" }
		-- https://github.com/LazyVim/LazyVim/discussions/1583
		-- event = "LazyFile",
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		worktrees = vim.g.git_worktrees,
	},
}
