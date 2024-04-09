-- TODO: Soft Fail and load Default theme
local theme = vim.g.theme_name or "tokyonight"
local variant = vim.g.theme_variant or theme == "tokyonight" and "night" or ""

local ok, err = pcall(require, theme)

if not ok then
	vim.api.nvim_err_writeln("Failed to load " .. theme .. "\n\n" .. err)
	return
end

if variant ~= nil then
	vim.cmd.colorscheme(theme .. "-" .. variant)
	return
end

vim.cmd.colorscheme(theme)
