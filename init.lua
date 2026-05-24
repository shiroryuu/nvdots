-- TODO: Plugins:
--  1. Direnv.nvim 
--  REFR: https://github.com/notashelf/direnv.nvim 
-- TODO: Fix deprecations
-- 1. nvim_err_write, nvim_write_ln() to nvim_echo()
    -- REFER: https://github.com/neovim/neovim/pull/31895
-- 2. vim.lsp.codelens.refresh() deprecated 
    -- REFER:
for _, source in ipairs({
		"shiroryuu.options",
		"shiroryuu.autocmds",
		"shiroryuu.lazy",
		"shiroryuu.mappings",
		"shiroryuu.colorscheme",
}) do
		local status_ok, fault = pcall(require,source)
		if not status_ok then
        -- vim.api.nvim_echo({{ "Error! Failed to load " .. source },{"\n"}, {fault}, {"\n"}}, false, { err })
        vim.api.nvim_err_write("Error! Failed to load " ..  source .. "\n\n" .. fault)
	end
end
