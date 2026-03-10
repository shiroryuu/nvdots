return {
	"nvim-mini/mini.nvim",
	event = "VeryLazy",
	config = function()
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.surround").setup()
		require("mini.indentscope").setup()
		require("mini.trailspace").setup()
        require("mini.icons").setup()

        -- TODO: Add separate Mini statusline configuration util page.

        -- DONE: Add Recording Label for macros.
		local statusline = require("mini.statusline")
        local utils_ui = require("shiroryuu.utils.ui")
        local mini_status_active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git           = MiniStatusline.section_git({ trunc_width = 40 })
            local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
            local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
            local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            -- local location      = MiniStatusline.section_location({ trunc_width = 75 })
            local location      = "%2l:%-2v"
            local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })
			local macro 		= utils_ui.recordingStatus()

            return MiniStatusline.combine_groups({
                { hl = mode_hl,                  strings = { mode, macro } },
                { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
                '%<', -- Mark general truncate point
                { hl = 'MiniStatuslineFilename', strings = { filename } },
                '%=', -- End left alignment
                { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                { hl = mode_hl,                  strings = { search, location } },
            })
        end
        statusline.setup({
		    use_icons = vim.g.icons_enabled ~= false,
            content = { active = mini_status_active },
        })
	end,
}
