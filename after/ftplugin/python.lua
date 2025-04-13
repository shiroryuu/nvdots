-- TODO: Use conform nvim instead

-- TODO: Fix formatting
local function format_on_save()
    -- TODO: Custom Keymaps
    local lsp = require("shiroryuu.utils.lsp")
    lsp.on_attach(function(client, bufnr)
        -- if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("Shiroryuu_fos_python", { clear = true }),
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        -- end
    end
    )
end

-- Smart Indent
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.autoindent = true
vim.opt_local.smartindent = true -- Adds some extra Python-aware indenting
