return {
	{
		"numToStr/Comment.nvim",
		dependencies = {
			{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true, opts = { enable_autocmd = false } },
		},
		keys = {
			{ "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
			{ "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
		},
		opts = function(_, opts)
			local commentstring_avail, commentstring =
				pcall(require, "ts_context_commentstring.integrations.comment_nvim")
			if commentstring_avail then
				opts.pre_hook = commentstring.create_pre_hook()
			end
		end,
	},
	{
		"mbbill/undotree",
		keys = {
			{ "<Leader>tu", "<Cmd>UndotreeToggle<CR>", desc = "Toggle Undo Tree" },
		},
	},
	-- TODO: Move Zenmode
	{
		"RRethy/vim-illuminate",
		event = "User LazyFile",
		opts = function()
			return {
				delay = 200,
				large_file_cutoff = 2000,
				min_count_to_highlight = 2,
				large_file_overrides = {
					providers = { "lsp" },
				},
				should_enable = function(bufnr)
					return require("shiroryuu.utils.buffer").is_valid(bufnr)
				end,
			}
		end,
		config = function(_, opts)
			require("illuminate").configure(opts)
			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end
			map("]]", "next")
			map("[[", "prev")
		end,

		keys = {
			{ "]]", desc = "Next Reference" },
			{ "[[", desc = "Previous Reference" },
		},
	},
}
