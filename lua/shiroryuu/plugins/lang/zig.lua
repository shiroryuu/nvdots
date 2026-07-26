return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "zig" } },
    },
    {
        "mason-org/mason.nvim",
        -- optional = ,
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { "zls", })
        end,
    },
}
