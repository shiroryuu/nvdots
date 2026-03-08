return{
	    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        event = "user Lazyfile",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = function()
            local harpoon = require("harpoon")
            return {
			    {
				    "<leader>ha",
				    function()
					    harpoon:list():add()
				    end,
				    desc = "Add file to harpoon",
			    },
			    {
				    "<leader>hl",
				    function()
					    harpoon.ui:toggle_quick_menu(harpoon:list())
				    end,
				    desc = "Harpoon quicklist",
			    },
                { "<C-h>", function() harpoon:list():select(1) end, desc="Harpoon Select file 1"},
                { "<C-t>", function() harpoon:list():select(2) end, desc="Harpoon Select file 2"},
                { "<C-n>", function() harpoon:list():select(3) end, desc="Harpoon Select file 3"},
                { "<C-s>", function() harpoon:list():select(4) end, desc="Harpoon Select file 4"},
                -- Toggle previous & next buffers stored within Harpoon list
                { "<C-S-P>", function() harpoon:list():prev() end, desc="Harpoon Buffer Prev"},
				-- This wont work (in alacritty)
                { "<C-S-N>", function() harpoon:list():next() end, desc="Harpoon Buffer Next"},
            }
        end,
    },
	{
        "mbbill/undotree",
        keys = {
            { "<leader>tu", "<Cmd>UndotreeToggle<CR>", desc = "Toggle Undo Tree" },
        },
    },
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

	{
		"catgoose/nvim-colorizer.lua",
		event = "User LazyFile",
		cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
		opts = {
			user_default_options = { names = false },
		},
		config = function(_, opts)
			local colorizer = require("colorizer")
			colorizer.setup(opts)
			for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
				if vim.t[tab].bufs then
					vim.tbl_map(function(buf)
						colorizer.attach_to_buffer(buf)
					end, vim.t[tab].bufs)
				end
			end
		end,
	},
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
                multiline = true,    -- enable multine todo comments
                multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
                multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
                before = "",         -- "fg" or "bg" or empty
                keyword = "wide",    -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                after = "fg",        -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
                comments_only = true, -- uses treesitter to match keywords in comments only
                max_line_len = 400,  -- ignore lines longer than this
                exclude = {},        -- list of file types to exclude highlighting
            },
            -- list of named colors where we try to extract the guifg from the
            -- list of highlight groups or use the hex color if hl not found as a fallback
            -- TODO: Delete alt style
            colors = {
                error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
                info = { "DiagnosticInfo", "#2563EB" },
                info_alt = { "DiagnosticInfo", "#BF24FB" },
                hint = { "DiagnosticHint", "#10B981" },
                hint_alt = { "Identifier", "#1C4B0A" },
                default = { "Identifier", "#7C3AED" },
                test = { "Identifier", "#FF00FF" },
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
            {
                "]t",
                function()
                    require("todo-comments").jump_next()
                end,
                desc = "Next Todo Comment",
            },
            {
                "[t",
                function()
                    require("todo-comments").jump_prev()
                end,
                desc = "Previous Todo Comment",
            },
            { "<leader>tt", "<Cmd>TodoTelescope<CR>",                         { desc = "Toggle TODO List" } },
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

}
