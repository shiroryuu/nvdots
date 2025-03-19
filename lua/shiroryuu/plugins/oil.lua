-- TODO: toggle tree structure
-- TODO: Set ceiling when going up directiory
-- TODO: Show git tracked hidden files
return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		dependencies = {
			{ "echasnovski/mini.icons", opts = {} },
			{ "nvim-tree/nvim-web-devicons" },
		},
		cmd = "Oil",
        -- event = "BufEnter",
        --[[ keys = {
            {"<Leader>-", "<CMD>Oil toggle_float<CR>", desc="" },
        }, ]]
		config = function()
            local opts = {
                default_file_explorer = true,
                view_options = {
                    show_hidden = false,
                },
            }
            require('oil').setup(opts)
            -- vim.keymap.set("n", "<Leader>-", require("oil").toggle_float)
        end,
	},
}
