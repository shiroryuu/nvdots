return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
        },
        branch = "master",
        version = false,
        event = { "User LazyFile", "VeryLazy" },
        build = function()
            local TS = require("nvim-treesitter")
            if not TS.get_installed then
                vim.api.nvim_err_write("Please restart Neovim and run `:TSUpdate` to use the `nvim-treesitter`")
                return
            end
            pcall(require("nvim-treesitter.install").update({ with_sync = true }))
        end,
        opts = {
            ensure_installed = {
                "bash",
				"c",
                "rust",
                "go",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"toml",
                "typescript",
				"vimdoc",
				"xml",
				"yaml",
            },
            indent = { enable = true },
            sync_install = false,
            auto_install = true,
            highlight = {
                -- `false` will disable the whole extension
                enable = true,
                disable = function(lang, buf)
                    if lang == "html" then
                        print("disabled")
                        return true
                    end

                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        vim.notify(
                            "File larger than 100KB treesitter disabled for performance",
                            vim.log.levels.WARN,
                            { title = "Treesitter" }
                        )
                        return true
                    end
                end,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = { "markdown" },
            },

        },
        config = function (_, opts)
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
		after = "nvim-treesitter",
        branch = "master",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},
}
