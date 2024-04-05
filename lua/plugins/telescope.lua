return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	config = function()
		require("telescope").setup({})
		local builtin = require("telescope.builtin")
		local map = vim.keymap.set
		map("n", "<Leader>f<CR>", builtin.resume, { desc = "Resume previous search" })
		map("n", "<Leader>ff", builtin.find_files, { desc = "Find files" })
		map("n", "<Leader>fh", builtin.help_tags, { desc = "Find help" })
		map("n", "<Leader>fg", builtin.git_files, { desc = "Find git files" })
		map("n", "<Leader>gb", builtin.git_branches, { desc = "Git Branches" })
		map("n", "<Leader>gc", builtin.git_commits, { desc = "Git Commits (Repo)" })
		map("n", "<Leader>gC", builtin.git_bcommits, { desc = "Git Branches (Current File)" })
		map("n", "<Leader>gt", builtin.git_status, { desc = "Git Status" })
		map("n", "<Leader>ft", builtin.colorscheme({ enable_preview = true }), { desc = "Find Themes" })
		map({ "i", "n" }, "<M-Tab>", function()
			if #vim.api.nvim_list_bufs() > 1 then
				builtin.buffers({ sort_mru = true, ignore_current_buffer = true })
			else
				vim.notify("No other buffers open !!")
			end
		end, { desc = "List all open buffers" })
		map("n", "<Leader>fw", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end, { desc = "Find word" })
		map("n", "<Leader>fws", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end, { desc = "Find String" })
		map("n", "<leader>fW", function()
			builtin.live_grep({
				additional_args = function(args)
					return vim.list_extend(args, { "--hidden", "--no-ignore" })
				end,
			})
		end, { desc = "Find words in all files" })
	end,
}
