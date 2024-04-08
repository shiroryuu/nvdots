for _, source in ipairs({
	"shiroryuu.options",
	"shiroryuu.autocmds",
	"shiroryuu.lazy",
	"shiroryuu.mappings",
}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		vim.api.nvim_err_write("Error! Failed to load " .. source .. "\n\n" .. fault)
	end
end

local theme = require("shiroryuu.colorscheme")
theme.setup("rose-pine")

-- TODO: Load polish
