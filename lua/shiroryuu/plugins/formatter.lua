-- TODO: Add autoisntall using  mason-tool-installer
-- NOTE: Create a common place to fetch Linters, Formatters and LSP Servers.
--       And use a utility function to fetch those.
-- NOTE: Conform contributer wrote a small function to handle this
-- REFR: https://github.com/stevearc/conform.nvim/issues/104#issuecomment-1750643030
return {
    "stevearc/conform.nvim",
    dependencies = {
        "williamboman/mason.nvim",
    },
    event = { "BufWritePre" },
    lazy = true,
    opts = {
        formatter_by_ft = {
            lua = { "stylua" },
            css = { "prettierd" },
            html = { "prettierd" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            json = { "jq" },
            -- Conform will run multiple formatters sequentially
            python = { "isort", "black" },
            rust = { "rustfmt", lsp_format = "fallback" },
            sh = { "shfmt" },
        },
        -- Set default options
        default_format_opts = {
            lsp_format = "fallback",
        },
    },
}
