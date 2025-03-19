-- TODO: Add toggle term (from astronvim)
-- TODO: Try blink.cmp
-- TODO: Move to oil.nvim
-- DONE: Move to oil.nvim
-- TODO: Advance Telescope multigrep
-- REFR: TJ Devries patch, https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/telescope.lua
-- NOTE: https://github.com/AstroNvim/AstroNvim/blob/cc6dc97f0f059a4ba5dda916ffc137d6609fa0ff/lua/astronvim/plugins/toggleterm.lua#L20
-- TODO: Add git modified files searh or display on telescope
-- TODO: Add python support
-- TODO: Rething vim mappings
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
-- DONE: Separate Lang module to enable & load language settings (extend base plugins)
-- TODO: Find a way to call utils (a global var ?)
