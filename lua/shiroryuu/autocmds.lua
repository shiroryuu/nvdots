local function augroup(name)
	return vim.api.nvim_create_augroup("shiroryuu_" .. name, { clear = true })
end

-- Change Working directory (Messing up with Telescope)
--[[ vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Change the working directory to the current file",
  group = vim.api.nvim_create_augroup("autochdir_grp", { clear = true }),
  pattern = "*",
  command = "cd %:p:h",
}) ]]

vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable wrap and spell for text like documents",
	group = augroup("auto_spell"),
	pattern = { "gitcommit", "markdown", "text", "plaintex" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Highlight Yanks
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking",
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
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

-- TODO: Add removing pdf and other build files when exiting vim from *.tex,*.md or README

-- TODO: Delete This
-- LspAttach
--[[
vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup("lsp_attach"),
	callback = function(event)
		vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = event.buf , desc = desc })
        end

        map("n", "gd", function()
            vim.lsp.buf.definition()
            end, "Show definition of current symbol")
        map("n", "gD", function()
            vim.lsp.buf.declaration()
            end, "Show declaration of current symbol")
        map("n", "K", vim.lsp.buf.hover)
        map("n", "gi", vim.lsp.buf.implementation)
        map("n", "gr", vim.lsp.buf.references, "References of current symbol")
        map({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, "LSP Code action")
        map("n", "<Leader>lD", vim.lsp.buf.type_definition, "Type Definition")
        map("n", "<Leader>lr", vim.lsp.buf.rename, "Rename")
        map("n", "<Leader>lf", function()
            vim.lsp.buf.format({ async = true })
            end, "Format buffer")
        map("n", "<Leader>li", "<cmd>LspInfo<CR>", "Lsp info")
        map("n", "<Leader>lwd", vim.lsp.buf.add_workspace_folder, "Add Workspace folder")
        map(
            "n",
            "<Leader>lwr",
            vim.lsp.buf.remove_workspace_folder,
            "Remove Workspace folder"
        )
        map("n", "<Leader>lw", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, "List Workspace Folders")

        map("n", "[d", function()
            vim.diagnostic.goto_next()
        end)
        map("n", "]d", function()
            vim.diagnostic.goto_prev()
        end)
        map("i", "<C-h>", function()
            vim.lsp.buf.signature_help()
        end)
	end,
})
]]

-- LazyFile and LazyGitFile from (LazyVim and Astro)
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
	desc = "User events for file detection (LazyFile and LazyGitFile)",
	group = augroup("file_user_events"),
	callback = function(event)
		local utils = require("shiroryuu.utils")
		if vim.b[event.buf].file_checked then
			return
		end
		vim.b[event.buf].file_checked = true
		vim.schedule(function()
			local current_file = vim.api.nvim_buf_get_name(event.buf)
			if not (current_file == "" or vim.bo[event.buf].buftype == "nofile") then
				utils.register_user_events("File")
				local folder = vim.fn.fnamemodify(current_file, ":p:h")
				if vim.fn.has("win32") == 1 then
					folder = ('"%s"'):format(folder)
				end
				if utils.exec_sys_cmd({ "git", "-C", folder, "rev-parse" }, false) then
					utils.register_user_events("GitFile")
					pcall(vim.api.nvim_del_augroup_by_name, "shiroryuu_file_user_events")
				end
				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(event.buf) and vim.bo[event.buf].buflisted then
						vim.api.nvim_exec_autocmds(
							event.event,
							{ buffer = event.buf, data = event.data, modeline = false }
						)
					end
				end)
			end
		end)
	end,
})
