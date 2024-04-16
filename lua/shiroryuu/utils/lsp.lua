local M = {}

function M.get_clients(opts)
    return (vim.lsp.get_clients or vim.lsp.get_active_clients){ opts }
end

function M.on_attach(fn)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            fn(client,buffer)
        end,
    })
end

return M
