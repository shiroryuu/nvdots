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

vim.api.nvim_create_autocmd("FileType", {
	desc = "Load lanaguage specific configs",
	group = augroup("lang_module"),
	pattern = "*",
	callback = function(event)
        -- print("Lang Path " .. event.match)
        local lang_module_path = "shiroryuu.lang." .. event.match
        local ok, lang_module = pcall(require, lang_module_path)

        if ok and lang_module and lang_module.setup then
            lang_module.setup()
        end
	end,
})

-- Highlight Yanks
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking",
	group = augroup("highlight_yank"),
	callback = function()
        -- NOTE: vim.highlight deprecated! (Use vim.hl) (nvim 0.11)
        -- REFR: https://github.com/neovim/neovim/commit/18b43c331d8a0ed87d7cbefe2a18543b8e4ad360
		vim.highlight.on_yank()
	end,
})

-- Oil
-- vim.api.nvim_create_autocmd("FileType", {
--     desc = "Remove buff defaults for oil",
--     group = augroup("oil"),
--     callback = function()
--         vim.opt_local.number = false
--         vim.opt_local.relativenumber = false
--         vim.opt_local.scrolloff = 0
--     end
-- })

-- Terminal
vim.api.nvim_create_autocmd("TermOpen", {
	desc = "Set defaults when opening Terminal",
	group = augroup("termopen_options"),
    callback = function ()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
        vim.bo.filetype = "terminal"
    end
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
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
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- TODO: Add removing pdf and other build files when exiting vim from *.tex,*.md or README

vim.api.nvim_create_autocmd("RecordingEnter", {
  pattern = "*",
  callback = function()
    require("shiroryuu.utils.status").notifyRecording()
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
