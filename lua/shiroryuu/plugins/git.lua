return {
		  {
		      "lewis6991/gitsigns.nvim",
		      enabled = vim.fn.executable("git") == 1,
		      version = false,
			  event = "VeryLazy",

		      -- event = "User LazyGitFile",
		      opts = function()
		          local get_icon = require("shiroryuu.utils.icon").get_unicon
		          return {
		              signs = {
		                  add = { text = get_icon("Git", "Sign", 1) },
		                  change = { text = get_icon("Git", "Sign", 1) },
		                  delete = { text = get_icon("Git", "Sign", 1) },
		                  topdelete = { text = " " },
		                  changedelete = { text = get_icon("Git", "Sign", 1) },
		                  untracked = { text = get_icon("Git", "Sign", 1) },
		              },
		              worktrees = vim.g.git_worktrees,
		              on_attach = function(buffer)
		                  local gs = package.loaded.gitsigns

		                  local function map(mode, l, r, desc)
		                      vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
		                  end

		                  -- stylua: ignore start
		                  map("n", "]h", gs.next_hunk, "Next Hunk")
		                  map("n", "[h", gs.prev_hunk, "Prev Hunk")
		                  map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
		                  map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
		                  map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
		                  map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
		                  map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
		                  map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
		                  map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
		                  map("n", "<leader>ghd", gs.diffthis, "Diff This")
		                  map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
		                  map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
		              end,
		          }
		      end,
		  },
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "<leader>lg", vim.cmd.Git)

			local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

			--[[
			local autocmd = vim.api.nvim_create_autocmd
			autocmd("BufWinEnter", {
				group = ThePrimeagen_Fugitive,
				pattern = "*",
				callback = function()
					if vim.bo.ft ~= "fugitive" then
						return
					end

					local bufnr = vim.api.nvim_get_current_buf()
					local opts = {buffer = bufnr, remap = false}
					vim.keymap.set("n", "<leader>p", function()
						vim.cmd.Git('push')
					end, opts)

					-- rebase always
					vim.keymap.set("n", "<leader>P", function()
						vim.cmd.Git({'pull',  '--rebase'})
					end, opts)

					-- NOTE: It allows me to easily set the branch i am pushing and any tracking
					-- needed if i did not set the branch up correctly
					vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
				end,
			})
			--]]

			vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
			vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
		end
	},
}
