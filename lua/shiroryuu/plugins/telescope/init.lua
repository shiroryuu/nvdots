return {
	"nvim-telescope/telescope.nvim",
    -- TODO: remove the version tag
    -- version = false
	tag = "0.1.6",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-smart-history.nvim" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	cmd = "Telescope",
	keys = function()
		local builtin = require("telescope.builtin")
		return {
			{ "<Leader>f<CR>", "<cmd>Telescope resume<CR>", mode = "n", desc = "Resume previous telescope (prompt)" },
			-- List open buffers
			{
				"<M-Tab>",
				function()
					if #vim.api.nvim_list_bufs() > 1 then
						builtin.buffers({ initial_mode = "normal", sort_mru = true, ignore_current_buffer = true })
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
					builtin.find_files({
						follow = true,
					})
				end,
				mode = "n",
				desc = "Find Files",
			},
			{ "<Leader>fh", "<cmd>Telescope help_tags<CR>", mode = "n", desc = "Find Help" },
			{
				"<Leader>sw",
				function()
					require("shiroryuu.plugins.telescope.multigrep")()
				end,
				desc = "Multigrep",
			},
			{ "<Leader>fg", "<cmd>Telescope git_files<CR>", mode = "n", desc = "Find Git Files" },
			{
				"<Leader>ft",
				function()
					builtin.colorscheme({ enable_preview = true })
				end,
				mode = "n",
				desc = "Find Themes",
			},
			{ "<Leader>fw", "<cmd>Telescope live_grep<CR>", mode = "n", desc = "Find Git Files" },
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
			{ "<Leader>gb", "<cmd>Telescope git_commits<cr>", desc = "Git Branches" },
			{ "<Leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits (Repo)" },
			{ "<Leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "Git Commits (Current File)" },
			{ "<Leader>gt", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
			-- DONE: Add current buffer fuzzy finder
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
