vim.opt.termguicolors = true
local theme = 'tokyonight'
-- local theme = 'rose-pine'
local ok, err = pcall(require, theme)

if not ok then
    vim.api.nvim_err_writeln("Failed to load " .. theme .. "\n\n" .. err)
    return
end

vim.cmd.colorscheme(theme)

