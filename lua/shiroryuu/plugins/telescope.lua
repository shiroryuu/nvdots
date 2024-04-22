return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	cmd = "Telescope",
	keys = function()
		local builtin = require("telescope.builtin")
		return {
			{
				"<Leader>f<CR>",
				function()
					builtin.resume()
				end,
				mode = "n",
				desc = "Resume previous search",
			},
			-- List open buffers
			{
				"<M-Tab>",
				function()
					if #vim.api.nvim_list_bufs() > 1 then
						builtin.buffers({ sort_mru = true, ignore_current_buffer = true })
					else
						vim.notify("No other buffers open !!")
					end
				end,
				mode = { "i", "n" },
				{ desc = "List all open buffers" },
			},
			-- Find
			-- TODO: change to sf [S]earch [F]iles (Faster keypress...)
			{
				"<Leader>ff",
				function()
					builtin.find_files()
				end,
				mode = "n",
				desc = "Find Files",
			},
			{
				"<Leader>fh",
				function()
					builtin.help_tags()
				end,
				mode = "n",
				desc = "Find Help",
			},
			{
				"<Leader>fg",
				function()
					builtin.git_files()
				end,
				mode = "n",
				desc = "Find Git Files",
			},
			-- TODO: Load all the themes before launching the picker.
			{
				"<Leader>ft",
				function()
					builtin.colorscheme({ enable_preview = true })
				end,
				mode = "n",
				desc = "Find Themes",
			},
			{
				"<Leader>fw",
				function()
					builtin.live_grep()
				end,
				mode = "n",
				desc = "Find Word",
			},
			{
				"<Leader>fW",
				function()
					builtin.live_grep({
						additional_args = function(args)
							return vim.list_extend(args, { "--hidden", "--no-ignore" })
						end,
					})
				end,
				mode = "n",
				desc = "Find Word in all files",
			},
			{
				"<Leader>fs",
				function()
					local word = vim.fn.expand("<cword>")
					builtin.grep_string({ search = word })
				end,
				mode = "n",
				desc = "Search Word",
			},
			{
				"<Leader>fS",
				function()
					local word = vim.fn.expand("<cWORD>")
					builtin.grep_string({ search = word })
				end,
				mode = "n",
				desc = "Search String",
			},
			-- Git
			{
				"<Leader>gb",
				function()
					builtin.git_branches()
				end,
				mode = "n",
				desc = "Git Branches",
			},
			{
				"<Leader>gc",
				function()
					builtin.git_commits()
				end,
				mode = "n",
				desc = "Git Commits (Repo)",
			},
			{
				"<Leader>gC",
				function()
					builtin.git_bcommits()
				end,
				mode = "n",
				desc = "Git Commits (Current File)",
			},
			{
				"<Leader>gt",
				function()
					builtin.git_status()
				end,
				mode = "n",
				desc = "Git Status",
			},
			-- TODO: Add current buffer fuzzy finder
			-- TODO: Add telescope integration with trouble
		}
	end,
	opts = function()
		local actions = require("telescope.actions")
		return {
			defaults = {
				mappings = {
					i = {
						["<c-n>"] = actions.cycle_history_next,
						["<c-p>"] = actions.cycle_history_prev,
						["<c-j>"] = actions.move_selection_next,
						["<c-k>"] = actions.move_selection_previous,
					},
					n = {
						q = actions.close,
					},
				},
			},
		}
	end,
	config = function(_, opts)
		require("telescope").setup(opts)
	end,
}
