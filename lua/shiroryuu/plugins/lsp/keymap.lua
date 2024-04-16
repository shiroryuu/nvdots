local utils = require("shiroryuu.utils")

local M = {}

M.keys = nil

function M.get_keys()
    if M.keys then
        return M.keys
    end
    -- set keymaps
    M.keys = {
        { "gd", function() vim.lsp.buf.definition() end, mode = "n", desc = "Show definition of current symbol" },
        { "gD", function() vim.lsp.buf.declaration() end, mode = "n", desc ="Show declaration of current symbol" },
        { "K", vim.lsp.buf.hover, mode = "n" }, 
        { "gi", vim.lsp.buf.implementation, mode = "n" },
        { "gr", vim.lsp.buf.references, mode = "n", desc = "References of current symbol" },
        { "<Leader>la", vim.lsp.buf.code_action, desc = "LSP Code action", mode = { "n", "v" }, },
        { "<Leader>lD", vim.lsp.buf.type_definition, mode = "n", desc = "Type Definition" },
        { "<Leader>lr", vim.lsp.buf.rename, mode = "n", desc = "Rename" },
        { "<Leader>lf", function() vim.lsp.buf.format({ async = true }) end, mode = "n", desc ="Format buffer" },
        { "<Leader>li", "<cmd>LspInfo<CR>", mode = "n", desc = "Lsp info" },
        { "<Leader>lwd", vim.lsp.buf.add_workspace_folder, mode = "n", desc = "Add Workspace folder" },
        { "<Leader>lwr", vim.lsp.buf.remove_workspace_folder, mode = "n", desc = "Remove Workspace folder" },
        { "<Leader>lw", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, mode = "n", desc = "List Workspace Folders" },
        { "[d", function() vim.diagnostic.goto_next() end, mode = "n" },
        { "]d", function() vim.diagnostic.goto_prev() end, mode = "n" },
        { "<C-h>", function() vim.lsp.buf.signature_help() end, mode = "i" },
    }
    return M.keys
end

function M.resove(buffer)
    local keys = require("lazy.core.handler.keys")
    if not keys.resolve then
        return {}
    end
    local specs = M.get()
    local opts = utils.plugins.opts("nvim-lspconfig")
    local clients = utils.lsp.get_clients({ bufnr = buffer })
    for _,client in ipairs(clients) do
        local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
        vim.list_extend(specs, maps)
    end
    return keys.resolve(spec)
end

function M.on_attach(_, buffer)
    local keys = require("lazy.core.handler.keys")
    local keymaps = M.resolve(buffer)

    for _, key in ipairs(keymaps) do
        if not key.has or M.has(buffer, key.has) then
            local opts = keys.opts(key)
            opts.has = nil
            opts.silent = opts.silent ~= false
            opts.buffer = buffer
            vim.keymap.set(key.mode or "n", key.lhs, key.rhs, opts)
        end
    end
end

return M
