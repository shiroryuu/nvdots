local is_format_on_save = false
local function format_code()
    local lsp = require("shiroryuu.utils.lsp")
    lsp.on_attach(function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("Shiroryuu_fos_html", { clear = true }),
            buffer = bufnr,
            callback = function()
                -- vim.lsp.buf.format({ async = false })
                require("conform").format { lsp_fallback = "never" }
                vim.cmd.update()
            end,
        })
        -- end
    end)
end

-- === Rust Editor Defaults (Buffer-Local Settings) ===
-- These settings will apply only to the current Rust buffer
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.expandtab = true

-- -- Auto-indentation styles
vim.bo.autoindent = true
vim.bo.textwidth = 120
--
-- -- Comment string (usually set automatically by filetype, but explicit doesn't hurt)
vim.bo.commentstring = "<!-- %s -->"

-- Optional: Set conceal level if needed for syntax features or plugins
-- 0: Show everything, 1-3: Conceal increasingly more
-- vim.opt_local.conceallevel = 0

vim.keymap.set({ "n", "v" }, "<Leader>cf", function()
    require("conform").format { formatters = {"prettier"}, lsp_fallback = "never", async = false, timeout_ms = 1000, }
    vim.cmd.update()
end, { desc = "Format the code" })


-- === End Editor Defaults ===

if is_format_on_save ~= false then
    format_code()
end

-- Format on Save
-- format_on_save()
