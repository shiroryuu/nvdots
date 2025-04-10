return {
    'mfussenegger/nvim-lint',
    event = "User LazyFile",
    opts = {
        -- Event to trigger linters
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        linters_by_ft = {
	        css = { "stylelint" },
            lua = { "selene" },
	        markdown = { "markdownlint" },
	        python = { "mypy" },
	        sh = { "shellcheck" },
	        yaml = { "yamllint" },
        },
    },
    config = function(opts)
        require("lint").try_lint()
    end,
}
