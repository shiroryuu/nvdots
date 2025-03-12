local M = {}

function M.toggle_background()
	vim.go.background = vim.go.background == "light" and "dark" or "light"
end

function M.toggle_inlay_hint()
    if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end
end

function M.toggle_buffer_inlay_hint(bufnr)
    local filter = { bufnr = bufnr or 0 }
    if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
    end
end

return M
