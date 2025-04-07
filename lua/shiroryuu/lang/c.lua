local M = {}

function M.setup()
    local extension = vim.bo.filetype
    print(vim.inspect(extension))
end

return M
