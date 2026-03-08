local M = {}

function M.register_user_events(event, instant)
	if type(event) == "string" then
		event = { pattern = event }
	end
	event = vim.tbl_deep_extend("force", { modeline = false }, event)
	event.pattern = "Lazy" .. event.pattern
	if instant then
		vim.api.nvim_exec_autocmds("User", event)
	else
		vim.schedule(function()
			vim.api.nvim_exec_autocmds("User", event)
		end)
	end
end

-- From Astrocore.cmd
function M.exec_sys_cmd(cmd, show_error)
	if type(cmd) == "string" then
		cmd = { cmd }
	end
	if vim.fn.has("win32") == 1 then
		cmd = vim.list_extend({ "cmd.exe", "/C" }, cmd)
	end
	local result = vim.fn.system(cmd)
	local success = vim.api.nvim_get_vvar("shell_error") == 0
	if not success and (show_error == nil or show_error) then
		vim.api.nvim_err_writeln(
			("Error running command %s\nError message:\n%s"):format(table.concat(cmd, " "), result)
		)
	end
	return success and assert(result):gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "") or nil
end

return M

