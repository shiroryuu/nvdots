local M = {}

local function is_ansible()
	local bufnr = 0

	local path = vim.api.nvim_buf_get_name(bufnr)
	local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "/n")

	-- check if file is in roles, tasks, or handlers folder
	local path_regex = vim.regex [[(tasks\|roles\|handlers)/]]

	if path_regex and path_regex:match_str(path) then
		return true
	end

	local regex = vim.regex [["hosts:\|tasks:"]]
	if regex and regex:match_str(content) then
		return true
	end

	return false
end

function M.setup()
    -- Install yaml for General Yaml

    local mason_nls_status, mason_nls = pcall(require, "mason-null-ls")
    local sources = { "yamllint" }

	if is_ansible() then
		--load ansible lsp and ansible linter
		vim.bo.filetype = "yaml.ansible"
		-- load default yaml linter
        sources = { "ansiblelint" }
    end

    if mason_nls_status then
        mason_nls.setup({ ensure_installed =  sources, automatic_installation = false})
    end
end

return M
