local function augroup(name)
	return vim.api.nvim_create_augroup("shiroryuu_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
	desc  = "Close files with q",
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"notify",
        "oil",
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
		vim.keymap.set("n", "q", vim.cmd.close, { buffer = event.buf, silent = true })
	end,
})

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
