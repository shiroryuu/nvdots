local is_format_on_save = true
local function format_on_save()
    local lsp = require("shiroryuu.utils.lsp")
    lsp.on_attach(function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("Shiroryuu_fos_rust", { clear = true }),
            buffer = bufnr,
            callback = function()
                -- vim.lsp.buf.format({ async = false })
                require("conform").format { lsp_fallback = "always" }
				vim.cmd.update()
            end,
        })
        -- end
    end)
end

-- === Rust Editor Defaults (Buffer-Local Settings) ===
-- These settings will apply only to the current Rust buffer

-- Indentation: Rust convention is 4 spaces.
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.expandtab = true

-- Auto-indentation styles
vim.opt_local.autoindent = true

-- Line length (optional): Many Rust projects aim for ~100 characters.
-- Set to 0 to disable automatic wrapping based on text width.
vim.opt_local.textwidth = 100

-- Comment string (usually set automatically by filetype, but explicit doesn't hurt)
vim.opt_local.commentstring = "// %s"

-- Optional: Set conceal level if needed for syntax features or plugins
-- 0: Show everything, 1-3: Conceal increasingly more
-- vim.opt_local.conceallevel = 0

-- === End Editor Defaults ===

if is_format_on_save ~= false then
    format_on_save()
end

-- Format on Save
-- format_on_save()

