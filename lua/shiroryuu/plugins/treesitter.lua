-- FIXME: TSUpdate fails on initial installation
return {
	-- Treesitter is a new parser generator tool that we can
	-- use in Neovim to power faster and more accurate
	-- syntax highlighting.
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		event = "User LazyFile", -- DONE: Add LazyFile event
		cmd = {
			"TSBufDisable",
			"TSBufEnable",
			"TSBufToggle",
			"TSDisable",
			"TSEnable",
			"TSToggle",
			"TSInstall",
			"TSInstallInfo",
			"TSInstallSync",
			"TSModuleInfo",
			"TSUninstall",
			"TSUpdate",
			"TSUpdateSync",
		},
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
			-- no longer trigger the **nvim-treesitter** module to be loaded in time.
			-- Luckily, the only things that those plugins need are the custom queries, which we make available
			-- during startup.
			-- REF: (From LazyVim) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			highlight = { enable = true },
			indent = { enable = true },
			sync_install = false,
			auto_install = true,
		},

		config = function(_, opts)
			-- fixes https://github.com/LazyVim/LazyVim/issues/628
			if type(opts.ensure_installed) == "table" then
				local added = {}
				opts.ensure_installed = vim.tbl_filter(function(lang)
					if added[lang] then
						return false
					end
					added[lang] = true
					return true
				end, opts.ensure_installed)
			end
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "User LazyFile", -- DONE: Switch to LazyFile
		enabled = true,
		opts = { mode = "cursor", max_lines = 3 },
		config = function()
			-- TODO: Rethink all the keymaps
			local tsc = require("treesitter-context")
			vim.keymap.set("n", "<Leader>tc", function()
				tsc.toggle()
			end, { desc = "Toggle Treesitter Context" })
		end,
	},
}
