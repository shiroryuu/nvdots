-- TODO: Update nvim to V0.11
-- TODO: Add keymap for lsp signature help
-- TODO: Add toggle term
-- TODO: Try blink.cmp
-- TODO: Port which-key to new specs and Fix the overlap warnings
-- DONE: Move to oil.nvim
-- TODO: Advance Telescope multigrep
-- REFR: TJ Devries patch, https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/telescope.lua
-- NOTE: https://github.com/AstroNvim/AstroNvim/blob/cc6dc97f0f059a4ba5dda916ffc137d6609fa0ff/lua/astronvim/plugins/toggleterm.lua#L20
-- DONE: Add python support
-- DONE: Add Snacks.nvim
-- TODO: Replace none-ls.nvim with nvim-lint & conform.nvim
-- TODO: Rethink vim mappings
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
-- DONE: Find a way to call utils (a global var ?) checkout shiroryuu.globals
