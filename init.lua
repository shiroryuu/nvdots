for _, source in ipairs({
	"shiroryuu.options",
	"shiroryuu.autocmds",
	"shiroryuu.lazy",
	"shiroryuu.mappings",
	"shiroryuu.colorscheme",
    "shiroryuu.polish",
}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		vim.api.nvim_err_write("Error! Failed to load " .. source .. "\n\n" .. fault)
	end
end
-- TODO: Separate Lang module to enable & load language settings (extend base plugins)
-- TODO: Find a way to call utils (a global var ?)
