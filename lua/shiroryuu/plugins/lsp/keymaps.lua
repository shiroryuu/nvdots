local utils = require("shiroryuu.utils")

local M = {}

M.keys = nil

function M.get_keys()
    if M.keys then
        return M.keys
    end
    M.keys = {
        { "gd", function() vim.lsp.buf.definition() end, mode = "n", desc = "Goto Definition" },
        { "gD", function() vim.lsp.buf.declaration() end, mode = "n", desc ="Goto Declaration" },
        { "gi", vim.lsp.buf.implementation, mode = "n", desc = "Goto Implementation"  },
        { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
        { "gr", "<cmd>Telescope lsp_references<CR>", mode = "n", desc = "List References of current symbol" },
        { "gy", vim.lsp.buf.type_definition, mode = "n", desc = "Goto T[y]pe Definition"  },
        { "K", vim.lsp.buf.hover, mode = "n" , desc = "Hover" }, 
        { "<Leader>ca", vim.lsp.buf.code_action, desc = "[c]ode [a]ction", mode = { "n", "v" }, },
        { "<Leader>cA", function()
            vim.lsp.buf.code_action({
                context = {
                    only = {
                        "source",
                    },
                    diagnostics = {},
                },
            })
        end,
            desc = "[c]ode source [A]ction",
        },
        { "<Leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
        { "<Leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
        { "<Leader>cr", vim.lsp.buf.rename, mode = "n", desc = "Rename" },
        { "<Leader>cf", function() vim.lsp.buf.format({ async = true }) end, mode = "n", desc ="Format buffer" },
        { "<Leader>cl", "<cmd>LspInfo<CR>", mode = "n", desc = "Lsp info" },
        { "<Leader>cwd", vim.lsp.buf.add_workspace_folder, mode = "n", desc = "Add Workspace folder" },
        { "<Leader>cwr", vim.lsp.buf.remove_workspace_folder, mode = "n", desc = "Remove Workspace folder" },
        { "<Leader>cw<CR>", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, mode = "n", desc = "List Workspace Folders" },
        { "[d", function() vim.diagnostic.goto_next() end, mode = "n" },
        { "]d", function() vim.diagnostic.goto_prev() end, mode = "n" },
        { "<C-h>", function() vim.lsp.buf.signature_help() end, mode = "i" },
    }
    return M.keys
end

function M.has(buffer, method)
  method = method:find("/") and method or "textDocument/" .. method
  local clients = require("shiroryuu.utils.lsp").get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

function M.resolve(buffer)
    local keys = require("lazy.core.handler.keys")
    if not keys.resolve then
        return {}
    end
    local specs = M.get_keys()
    -- TODO: refactor this
    local opts = require("shiroryuu.utils.plugin").get_opts("nvim-lspconfig")
    local clients = require("shiroryuu.utils.lsp").get_clients({ bufnr = buffer })
    for _,client in ipairs(clients) do
        local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
        vim.list_extend(specs, maps)
    end
    return keys.resolve(specs)
end

function M.on_attach(_, buffer)
    local keys = require("lazy.core.handler.keys")
    local keymaps = M.resolve(buffer)

    for _, key in pairs(keymaps) do
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
