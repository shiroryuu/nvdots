-- TODO: Add scroll binding in Telescope
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
    cmd = "Telescope",
    keys = {
    },
        keys = {
        { "<Leader>f<CR>", function() require("telescope.builtin").resume() end, mode = "n", desc = "Resume previous search" },
        -- List open buffers
        {"<M-Tab>", function()
            if #vim.api.nvim_list_bufs() > 1 then
                builtin.buffers({ sort_mru = true, ignore_current_buffer = true })
            else
                vim.notify("No other buffers open !!")
            end
        end, mode = {"i","n"}, { desc = "List all open buffers" } },
        -- Find
        { "<Leader>ff", function() require("telescope.builtin").find_files() end, mode = "n", desc = "Find Files" },
        { "<Leader>fh", function() require("telescope.builtin").help_tags() end, mode = "n", desc = "Find Help" },
        { "<Leader>fg", function() require("telescope.builtin").git_files() end, mode = "n", desc = "Find Git Files" },
        { "<Leader>ft", function() require("telescope.builtin").colorscheme({enable_preview = true}) end, mode = "n", desc = "Find Themes" },
        -- TODO: Change this to fs and FS and use live_grep in fw
        { "<Leader>fw", function()
			local word = vim.fn.expand("<cword>")
            require("telescope.builtin").grep_string({ search = word})
        end, mode = "n", desc = "Find Word" },
        { "<Leader>fW", function()
			local word = vim.fn.expand("<cWORD>")
            require("telescope.builtin").grep_string({ search = word})
        end, mode = "n", desc = "Find Word" },
        -- Git
        { "<Leader>gb", function() require("telescope.builtin").git_branches() end, mode = "n", desc = "Git Branches" },
        { "<Leader>gc", function() require("telescope.builtin").git_commits() end, mode = "n", desc = "Git Commits (Repo)" },
        { "<Leader>gC", function() require("telescope.builtin").git_bcommits() end, mode = "n", desc = "Git Commits (Current File)" },
        { "<Leader>gt", function() require("telescope.builtin").git_status() end, mode = "n", desc = "Git Status" },
    },
    -- TODO: Add opts in future
	config = function()
		require("telescope").setup({})
	end,
}
