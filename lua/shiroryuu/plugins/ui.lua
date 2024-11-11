return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = function()
			local get_icon = require("shiroryuu.utils.icon").get_unicon
			return {
				plugins = { spelling = true },
				icons = {
					group = vim.g.icons_enabled ~= false and "" or "+",
				},
				defaults = {
					mode = { "n", "v" },
					["g"] = { name = "+goto" },
					["gs"] = { name = "+surround" },
					["z"] = { name = "+fold" },
					["]"] = { name = "+next" },
					["["] = { name = "+prev" },
					["<M-Tab>"] = { get_icon("General", "Files", 1) .. "Open Buffers" },
					["<Leader>b"] = { get_icon("General", "Window", 1) .. "Buffer" },
					["<Leader>c"] = { get_icon("General", "Code", 1) .. "Code/LSP" },
					["<Leader>d"] = { get_icon("General", "Dap", 1) .. "Debugger" },
					["<Leader>e"] = { get_icon("General", "Folders", 1) .. "Neotree toggle" },
					["<Leader>f"] = { get_icon("General", "Search", 1) .. "Find" },
					["<Leader>h"] = { get_icon("General", "Window", 1) .. "Harpoon" },
					["<Leader>g"] = { get_icon("General", "Git", 1) .. "Git" },
					["<Leader>gh"] = { get_icon("Git", "Hunk", 1) .. "Hunk" },
					["<Leader>gg"] = { get_icon("General", "GitAlt", 1) .. "LazyGit" },
					["<Leader>p"] = { get_icon("General", "Arrow", 1) .. "Projects" },
					["<Leader>q"] = { get_icon("General", "Close", 1) .. "Quit" },
					["<Leader>t"] = { get_icon("General", "Toggles", 2) .. "Toggles" },
					["<Leader>w"] = { get_icon("General", "Save", 1) .. "Save" },
					["<Leader>x"] = { get_icon("General", "Diagnostics", 1) .. "Diagnostics" },
				},
			}
		end,
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
	-- TODO: Add REFR or REFS
    -- DONE: Add DONE
	{
		"folke/todo-comments.nvim",
		event = "User LazyFile",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
            signs = true, -- show icons in the signs column
            sign_priority = 8, -- sign priority
            -- keywords recognized as todo comments
            keywords = {
                FIX = {
                    icon = " ", -- icon used for the sign, and in search results
                    color = "error", -- can be a hex color, or a named color (see below)
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                    -- signs = false, -- configure signs for some keywords individually
                },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                DONE = { icon = " ", color = "hint" },
                REFR = { icon = " ", color = "#BF24FB", alt = { "REFER", "REF", "REFS" } },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
            gui_style = {
                fg = "NONE", -- The gui style to use for the fg highlight group.
                bg = "BOLD", -- The gui style to use for the bg highlight group.
            },
            merge_keywords = true, -- when true, custom keywords will be merged with the defaults
            -- highlighting of the line containing the todo comment
            -- * before: highlights before the keyword (typically comment characters)
            -- * keyword: highlights of the keyword
            -- * after: highlights after the keyword (todo text)
            highlight = {
                multiline = true, -- enable multine todo comments
                multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
                multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
                before = "", -- "fg" or "bg" or empty
                keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                after = "fg", -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
                comments_only = true, -- uses treesitter to match keywords in comments only
                max_line_len = 400, -- ignore lines longer than this
                exclude = {}, -- list of file types to exclude highlighting
            },
            -- list of named colors where we try to extract the guifg from the
            -- list of highlight groups or use the hex color if hl not found as a fallback
            -- TODO: Delete alt style
            colors = {
                error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
                info = { "DiagnosticInfo", "#2563EB" },
                info_alt = {"DiagnosticInfo", "#BF24FB"},
                hint = { "DiagnosticHint", "#10B981" },
                hint_alt = { "Identifier", "#1C4B0A" },
                default = { "Identifier", "#7C3AED" },
                test = { "Identifier", "#FF00FF" }
            },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                },
                -- regex that will be used to match keywords.
                -- don't replace the (KEYWORDS) placeholder
                pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
            },

		},
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
			{ "<Leader>tt", "<Cmd>TodoTelescope<CR>", { desc = "Toggle TODO List" } },
            { "<leader>tT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
        },
	},
	{
		"folke/zen-mode.nvim",
		dependencies = { "folke/twilight.nvim" },
		keys = {
			{ "<Leader>tz", "<Cmd>ZenMode<CR>", { desc = "Toggle Zen mode" } },
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
	{
		"rcarriga/nvim-notify",
		event = "BufEnter",
		opts = {
			stages = "static",
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		-- TODO: Add keys to dismiss
		init = function()
			vim.notify = require("notify")
		end,
	},
}
