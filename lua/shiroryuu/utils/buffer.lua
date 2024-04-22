local M = {}

function M.close(bufnr, force)
	if not bufnr or bufnr == 0 then
		bufnr = vim.api.nvim_get_current_buf()
	end
	local buftype = vim.bo[bufnr].buftype
	vim.cmd(("silent! %s %d"):format((force or buftype == "terminal") and "bdelete!" or "confirm bdelete", bufnr))
end

function M.close_all(keep_current, force)
	if keep_current == nil then
		keep_current = false
	end
	local current = vim.api.nvim_get_current_buf()
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if not keep_current or bufnr ~= current then
			M.close(bufnr, force)
		end
	end
end

function M.is_valid(bufnr)
	if not bufnr then
		bufnr = 0
	end
	return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end

return M
