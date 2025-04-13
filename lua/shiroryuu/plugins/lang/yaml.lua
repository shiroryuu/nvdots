return {
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
                "ansible-lint",
                "ansible-language-server",
                "yamllint",
            })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
                ansiblels = {},
			},
		},
	},
}
