local M = {}

function M.toggle_background()
    vim.go.background = vim.go.background == "light" and "dark" or "light"
end

return M
