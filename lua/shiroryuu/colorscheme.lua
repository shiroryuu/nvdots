local theme = vim.g.theme_name or "tokyonight"
local variant = vim.g.theme_variant or theme == "tokyonight" and "night" or ""

local ok, err = pcall(require, theme)

-- TODO: builtin theme errors out
if not ok then
	vim.api.nvim_err_writeln("Failed to load colorscheme:" .. theme .. "\nError:\n" .. err)
	print("\n Loading colorscheme theme Tokyonight\n")
	if pcall(require, "tokyonight") then
		vim.cmd.colorscheme("tokyonight")
	end
	return
end

if variant ~= "" then
	vim.cmd.colorscheme(theme .. "-" .. variant)
	return
end

vim.cmd.colorscheme(theme)
