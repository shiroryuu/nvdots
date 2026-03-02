return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
    },
    cmd = "ConformInfo",
    lazy = true,
    config = function()
        -- print("format is " .. vim.inspect(formatters))
        require("conform").setup {
            formatter_by_ft = {
	            bib = { "trim_whitespace", "bibtex-tidy" },
                c = { "clang-format" },
                cpp = { "clang-format" },
	            css = { "stylelint", "prettier" },
	            javascript = { "biome" },
	            json = { "biome" },
	            jsonc = { "biome" },
                jinja = { "djlint" },
	            lua = { "stylua" },
	            html = { "prettier", "djlint" },
	            markdown = {
		            "markdown-toc",
		            "markdownlint",
		            -- "injected",
	            },
	            python = { "black" },
                rust = { "rustfmt", lsp_format = "fallback" },
	            sh = { "shellcheck", "shfmt" },
	            typescript = { "biome" },
	            yaml = { "prettier" },
	            ["_"] = { "trim_whitespace", "trim_newlines", "squeeze_blanks" },
	            ["*"] = { "codespell" },
            },
            -- format_on_save = {
            --     lsp_fallback = true,
            --     async = false,
            --     timeout_ms = 1000,
            -- },
            default_format_opts = {
                lsp_format = "fallback",
            },
        }
    end,
}
