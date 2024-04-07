-- Change Working directory (Messing up with Telescope)
--[[ vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Change the working directory to the current file",
  group = vim.api.nvim_create_augroup("autochdir_grp", { clear = true }),
  pattern = "*",
  command = "cd %:p:h",
}) ]]

vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable wrap and spell for text like documents",
	group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
	pattern = { "gitcommit", "markdown", "text", "plaintex" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Highlight Yanks
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking",
	group = vim.api.nvim_create_augroup("shiroryuu_highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("shiroryuu_lspattach", { clear = true }),
	callback = function(event)
		vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local opts = { buffer = event.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, { desc = "Show definition of current symbol", opts })
		vim.keymap.set("n", "gD", function()
			vim.lsp.buf.declaration()
		end, { desc = "Show declaration of current symbol", opts })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References of current symbol", opts })
		vim.keymap.set({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, { desc = "LSP Code action", opts })
		vim.keymap.set("n", "<Leader>lD", vim.lsp.buf.type_definition, { desc = "Type Definition", opts })
		vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, { desc = "Rename", opts })
		vim.keymap.set("n", "<Leader>lf", function()
			vim.lsp.buf.format({ async = true })
		end, { desc = "Format buffer", opts })
		vim.keymap.set("n", "<space>lwd", vim.lsp.buf.add_workspace_folder, { desc = "Add Workspace folder", opts })
		vim.keymap.set(
			"n",
			"<space>lwr",
			vim.lsp.buf.remove_workspace_folder,
			{ desc = "Remove Workspace folder", opts }
		)
		vim.keymap.set("n", "<Leader>lw", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { desc = "List Workspace Folders", opts })

		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
	end,
})
