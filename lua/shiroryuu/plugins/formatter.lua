local formatters = {
	bib = { "trim_whitespace", "bibtex-tidy" },
    c = { "clang-format" },
    cpp = { "clang-format" },
	css = { "stylelint", "prettier" },
	javascript = { "biome" },
	json = { "biome" },
	jsonc = { "biome" },
	lua = { "stylua" },
	html = { "prettier" },
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
}

return {
    "stevearc/conform.nvim",
    dependencies = {
        "williamboman/mason.nvim",
    },
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    lazy = true,
    config = function()
        -- print("format is " .. vim.inspect(formatters))
        require("conform").setup {
            formatter_by_ft = formatters,
            default_format_opts = {
                lsp_format = "fallback",
            },
        }
    end,
}
