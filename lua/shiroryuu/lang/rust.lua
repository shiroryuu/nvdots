-- TODO: Add saecki/crates.nvim to manage Cago toml
-- TODO: Notification
local M = {}

M.buf = 0

-- FIX: Fix formatting
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
    end)
end

function M.setup()
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

    -- LSP
    local mason_nls_status, mason_nls = pcall(require, "mason-null-ls")
    local lspconfig_status, lspconfig = pcall(require, "lspconfig")
    local sources = { -- In your lazy.nvim plugins spec for mason-lspconfig.nvim
        "rust_analyzer", -- LSP Server
        "codelldb", -- DAP Debugger Adapter (LLDB based)
    }
    if mason_nls_status then
        mason_nls.setup({ ensure_installed = sources, automatic_installation = false })
    end

    if not lspconfig_status then
        vim.notify("lspconfig not found. Skipping Rust setup", vim.log.levels.WARN)
        return
    end

    lspconfig.rust_analyzer.setup({
        -- Server-specific settings for rust-analyzer
        -- See :help lspconfig-servers-rust_analyzer and rust-analyzer docs
        settings = {
            ["rust-analyzer"] = {
                -- Enable clippy diagnostics on save (or via command)
                checkOnSave = {
                    command = "clippy",
                    -- extraArgs = {"--", "-A", "clippy::some-allowance"}, -- Example args
                },
                -- Example inlay hints configuration (adjust to your preference)
                inlayHints = {
                    bindingModeHints = { enable = false }, -- Preference
                    chainingHints = { enable = true },
                    closingBraceHints = { enable = true, minLines = 10 },
                    lifetimeElisionHints = { enable = false, useParameterNames = false }, -- Preference
                    maxLength = 120,
                    parameterHints = { enable = true },
                    renderColons = true,
                    typeHints = { enable = true, hideSelf = true, hideClosureInitialization = false },
                },
                -- Ensure proc-macro support is enabled (usually default)
                procMacro = { enable = true },
                -- Improve cargo check integration
                cargo = {
                    loadOutDirsFromCheck = true,
                    -- features = "all", -- Or specify features
                },
                -- You can add many other rust-analyzer specific settings here
            },
        },
    })

    -- Format on Save
    format_on_save()
end

return M
