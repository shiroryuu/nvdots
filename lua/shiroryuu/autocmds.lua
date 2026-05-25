local function augroup(name)
	return vim.api.nvim_create_augroup("shiroryuu_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable wrap and spell for text like documents",
	group = augroup("auto_spell"),
	pattern = {
        "gitcommit",
        "markdown",
        "text",
        "plaintex",
        "groff"
    },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
        vim.opt.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt.signcolumn = "no"
        vim.keymap.set('n', 'k', 'gk', { noremap = true })
        vim.keymap.set('n', 'j', 'gj', { noremap = true })
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	desc  = "Maximize size",
	group = augroup("maximize_size"),
	pattern = {
        "*.txt",
        "fugitive://*",
    },
    callback = function (event)
        local ft = vim.bo[event.buf].filetype
        if ft == "help" or ft == "fugitive" then
            vim.bo[event.buf].buflisted = false
            vim.cmd('wincmd T')
        end
    end,
})

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
        "fugitive",
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

vim.api.nvim_create_autocmd("RecordingEnter", {
  pattern = "*",
  callback = function()
    require("shiroryuu.utils.ui").notifyRecording()
    vim.g.macro_recording = "Recording @" .. vim.fn.reg_recording()
    vim.cmd("redrawstatus")
  end,
})

-- Autocmd to track the end of macro recording
vim.api.nvim_create_autocmd("RecordingLeave", {
  pattern = "*",
  callback = function()
    vim.g.macro_recording = ""
    vim.cmd("redrawstatus")
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight the text on yanking",
	group = augroup("highlight_on_copy"),
	callback = function()
		if vim.fn.has("nvim-0.11") then
			vim.hl.on_yank()
		end
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
